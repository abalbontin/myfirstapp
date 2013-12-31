//
//  MainViewController.m
//  GasAll
//
//  Created by Álvaro Balbontín Gutiérrez on 31/12/13.
//  Copyright (c) 2013 Mobivery. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // We translucent the toolbar with the current color.
    self.toolbar.alpha = 0.9;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
