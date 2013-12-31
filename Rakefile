# Rakefile
# Copyright (C) 2011,2012,2013 Mobivery

require "yaml"
require "openssl"
require "tempfile"
require "json"
require "net/http"
require "rexml/document"
require "rubygems"

STDOUT.sync = true

# A class with one single static method to load the provisioning profile data.
class ProvisioningProfile
  # Loads the provisioning profile file and extracts its UUID and the common name of the certificate which is linked.
  def self.load(path)
    print "Getting mobile provisioning data from #{path}...\n"
    uuid = nil
    identity = nil
    begin
      file = File.read(path)
    rescue
      print "Unable to find #{path} file!\n"
      exit(-1)
    end
    begin      
      uuid = `security cms -D -i #{path} > mobileprovision.plist && /usr/libexec/PlistBuddy -c 'Print :UUID' mobileprovision.plist`.strip
      cert = OpenSSL::X509::Certificate.new(`/usr/libexec/PlistBuddy -c 'Print :DeveloperCertificates:0' mobileprovision.plist`)
      cert.subject.to_a.each do | entry |
        if entry[0] == "CN" then identity = entry[1] end
      end
      print "Done!\n"
    rescue
      print "Unable to load #{path} data! #{$!}\n"
      exit(-1)
    end
    return identity, uuid
  end
end

# A class representing the build process of continuous integration for iOS projects.
class Build
  public
  # Initializes the internal structures needed to compile, sign, package and publish
  # the app being built.
  # Params:
  # +receiver+:: the receiver of the build. Related to certificates and provisioning profiles.
  # +build_type+:: the type of build. This can be
  # - snapshot: takes a picture of the status of the implementation by only running unit and component tests.
  # - nightly: runs all tests, compiles the main target and publishes the installer.
  # - release: compiles the main target for internal release and client demo and publishes both installers.
  def initialize(build_type, receiver)    
    @build_type = build_type
    # Load build parameters.
    @params = YAML.load_file("build.yml")
    @receiver = receiver
    @productName = @params["project_file_name"]
  end
  def start(publish = true)
    install_certificates_and_provisioning_profiles
    set_release_version_and_build_number unless @build_type == "snapshot"
    compile
    package unless @build_type == "snapshot"
    # publish_on_testflight unless publish == false
    publish_on_hockeyapps unless publish == false
  end
  private
  def install_certificates_and_provisioning_profiles
    # Get team's certificate and provisioning profile.
    run("svn export https://svn.mmip.es/mobiguo/ci-commons/certs/#{@receiver} certs/#{@receiver} --force --username redmine --password r3dm1n3")
    # Load certs parameters.
    @certs_parameters = YAML.load_file("certs/#{@receiver}/config.yml")
    # Load provisioning profile and get certificate identity and provisioing UUID.
    @identity, @uuid = ProvisioningProfile.load("certs/#{@receiver}/#{@certs_parameters['provisioning_profile']['file_name']}")
    # Install certificates.
    default_keychain = `security default-keychain`.strip
    installation_file = "certs/#{@receiver}/#{@certs_parameters["certificate"]["file_name"]}"
    installation_password = @certs_parameters["certificate"]["password"]
    `security import "#{installation_file}" -P #{installation_password} -k #{default_keychain}`
    # Install provisioning profiles (naming destination file with its UUID as the iPhone Configuration Utility does).
    installation_file = "certs/#{@receiver}/#{@certs_parameters["provisioning_profile"]["file_name"]}"
    FileUtils.cp(installation_file, File.expand_path("#{ENV["HOME"]}/Library/MobileDevice/Provisioning Profiles/#{@uuid}.mobileprovision"), :verbose => true)
  end
  def set_release_version_and_build_number
    hockeyapp_distribution_tags = @params["builds"][@build_type]["hockeyapp"]["distribution_tags"][@receiver].join(" , ")
    # Set CFBundleVersion (build number).
    gitversion = `git log -1 --pretty=oneline`[0,7] + "-" +  hockeyapp_distribution_tags
    run("agvtool new-version -all #{gitversion}")
    # Set CFBundleShortVersionString (release version).
    # See https://developer.apple.com/library/ios/#documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html    
    version = @build_type == "release" ? ENV["VERSION"] + "-" +  hockeyapp_distribution_tags : @params["builds"][@build_type]["default_version"] + "-" + gitversion
    run("agvtool new-marketing-version #{version}")
  end
  def compile
    # Compile for iphoneos (run on device) and iphonesimulator (run on simulator in QA services).
    scheme = @params["builds"][@build_type]["scheme"]
    workspace = @params["builds"][@build_type]["workspace"]
    main_target = @params["builds"][@build_type]["main_target"]
    test_targets = @params["builds"][@build_type]["test_targets"]
    build_path = get_build_path
    developer_dir = ENV['DEVELOPER_DIR'] ||= `xcode-select --print-path`.strip
    if test_targets then
      for test_target in test_targets do
        # Set proper environment variables for GHUnit to run tests and generate tests results.
        ENV["WRITE_JUNIT_XML"] = "YES"
        ENV["GHUNIT_CLI"] = "1"
        print "WRITE_JUNIT_XML=YES GHUNIT_CLI=1\n"
        run("xcodebuild -target #{test_target} -configuration Debug -sdk iphonesimulator clean build DEVELOPER_DIR=\"#{developer_dir}\"")
      end
    end
    if main_target then
      begin
        run("xcodebuild -scheme #{scheme} -workspace #{workspace}.xcworkspace -configuration Debug -sdk iphoneos clean build CONFIGURATION_BUILD_DIR=#{build_path} CODE_SIGN_IDENTITY='#{@identity}' PROVISIONING_PROFILE='#{@uuid}' ONLY_ACTIVE_ARCH=YES DEVELOPER_DIR=\"#{developer_dir}\"")
      end
    end
  end
  def package
    build_path = get_build_path
    # Package the app.
    run("xcrun -sdk iphoneos PackageApplication -v \"#{build_path}/#{@productName}.app\" -o \"#{build_path}/#{@productName}.ipa\"")
  end
  def publish_on_testflight
    build_path = get_build_path
    # Zip de dSYM bundle.
    run("zip -r #{build_path}/#{@productName}.app.dSYM.zip #{build_path}/#{@productName}.app.dSYM")
    # Publish the app in TestFlight.
    testflight_api_token = @params["builds"][@build_type]["testflight"]["api_token"]
    testflight_team_token = @params["builds"][@build_type]["testflight"]["team_token"][@receiver]
    testflight_distribution_lists = @params["builds"][@build_type]["testflight"]["distribution_lists"][@receiver]
    run("curl --silent http://testflightapp.com/api/builds.json -F file=@#{build_path}/#{@productName}.ipa -F dsym=@#{build_path}/#{@productName}.app.dSYM.zip -F api_token='#{testflight_api_token}' -F team_token='#{testflight_team_token}' -F notes='#{testflight_notes}' -F notify=False -F replace=True -F distribution_lists='#{testflight_distribution_lists.join(", ")}'")
  end
  def publish_on_hockeyapps
    build_path = get_build_path
    # Zip de dSYM bundle.
    run("zip -r #{build_path}/#{@productName}.app.dSYM.zip #{build_path}/#{@productName}.app.dSYM")
    # Publish the app in Hockeyapps.
    hockeyapp_app_id = @params["builds"][@build_type]["hockeyapp"]["app_id"]
    hockeyapp_team_token = @params["builds"][@build_type]["hockeyapp"]["team_token"]
    hockeyapp_distribution_tags = @params["builds"][@build_type]["hockeyapp"]["distribution_tags"][@receiver]
    run("curl -F 'status=2' -F 'notify=0' -F 'notes_type=0' -F 'ipa=@#{build_path}/#{@productName}.ipa' -F 'dsym=@#{build_path}/#{@productName}.app.dSYM.zip' -F 'tags=#{hockeyapp_distribution_tags.join(", ")}' -H 'X-HockeyAppToken: #{hockeyapp_team_token}' https://rink.hockeyapp.net/api/2/apps/#{hockeyapp_app_id}/app_versions")
  end
  def get_build_path
    return "#{Dir.pwd}/build/Debug-iphoneos"
  end
  def run(command)
    print "#{command}... "
    output = `#{command} 2> /dev/null`
    if $?.exitstatus > 0 then
      print "Failed!\n"
      puts output
      exit(-1)
    else
      print "Done!\n"
    end
  end
end

class BuildConstructor
  def initialize(build_type)
    @build_type = build_type
    @params = YAML.load_file("build.yml")
    @build = @params["builds"][build_type]
  end
  def start
    distribution_lists = @build["receivers"]
    distribution_lists.each do |receiver|
      build = Build.new(@build_type, receiver)
      build.start
    end
  end
end

namespace :build do
  task :snapshot do
    build = BuildConstructor.new("snapshot")
    build.start
  end
  task :nightly do
    build = BuildConstructor.new("nightly")
    build.start
  end
  task :release do
    build = BuildConstructor.new("release")
    build.start
  end
end


namespace :generate do
  desc 'Web services consumer code generator'
  task :ws do
    puts 'Cleaning previous executions (if any)...'.cyan
    `rm -rf ws-gen >/dev/null`
    `rm -rf ws-def >/dev/null`
  
    puts 'Downloading definitions and generator'.cyan
    `git clone https://github.com/mobivery/service-generator.git ws-gen`
    `git clone https://github.com/mobivery/service-definitions.git ws-def`
    
    puts 'Loading generator parameters'.cyan
    @params = YAML.load_file("generate.yml")
    project_file_name = @params["project_file_name"]
    ws_definitions_file_name = @params["ws_definitions_file_name"]
    spreadsheet_name = @params["spreadsheet_name"]
    package = @params["package"]
  
    base_dir = Dir.pwd
    definition_path = base_dir + "/ws-def/#{ws_definitions_file_name}.xml"
    generated_code_path = base_dir + "/#{project_file_name}/"
  
    puts 'Generating code'.cyan
    Dir.chdir 'ws-gen' do
      `bundle install`
      `ruby generator.rb -f #{definition_path} -package #{package} -pn #{project_file_name} -iOutput #{generated_code_path} -iVersion 3.0`
    end
  
    puts 'Deleting temporals'.cyan
    `rm -rf ws-def > /dev/null`
    `rm -rf ws-gen > /dev/null`
  
    puts 'Done!'.green
  
  end
  
  desc 'Localizable generator'
  task :loc do
    puts 'Generating localizables'.cyan
    `localize`    
    puts 'Done!'.green
  end
 
  desc 'Setup'
  task :setup do
    Rake::Task["generate:loc"].invoke
    Rake::Task["generate:ws"].invoke
  end
  
  # Run setup by default
  task :default => :setup
end

class String
  def self.colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end
 
  def cyan
    self.class.colorize(self, 36)
  end
 
  def green
    self.class.colorize(self, 32)
  end
end
