/*
 * Author: Andreas Linde <mail@andreaslinde.de>
 *
 * Copyright (c) 2012-2013 HockeyApp, Bit Stadium GmbH.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */


#import <Foundation/Foundation.h>

typedef enum {
  // default and new messages from SDK per default
  BITFeedbackMessageStatusSendPending = 0,
  // message is in conflict, happens if the message is already stored on the server and tried sending it again
  BITFeedbackMessageStatusInConflict = 1,
  // sending of message is in progress
  BITFeedbackMessageStatusSendInProgress = 2,
  // new messages from server
  BITFeedbackMessageStatusUnread = 3,
  // messages from server once read and new local messages once successful send from SDK
  BITFeedbackMessageStatusRead = 4,
  // message is archived, happens if the thread is deleted from the server
  BITFeedbackMessageStatusArchived = 5
} BITFeedbackMessageStatus;

@interface BITFeedbackMessage : NSObject {
}

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSDate *date;
@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSString *token;
@property (nonatomic) BITFeedbackMessageStatus status;
@property (nonatomic) BOOL userMessage;

@end
