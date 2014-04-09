//
//  Contattaci.h
//  MedjugorjeLite
//
//  Created by Guglielmo Puglia on 05/06/12.
//  Copyright (c) 2012 gugosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@class Email;


@interface Contattaci : UIViewController <MFMailComposeViewControllerDelegate> 
{
	IBOutlet UILabel *message;
}

@property (nonatomic, retain) IBOutlet UILabel *message;

-(IBAction)showPicker:(id)sender;
-(IBAction)showPicker2:(id)sender;
-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;

@end