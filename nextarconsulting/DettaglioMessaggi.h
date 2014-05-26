//
//  DettaglioMessaggi.h
//  MedjugorjeLite
//
//  Created by Guglielmo Puglia on 21/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
/*#import "FBConnect.h"
#import <Twitter/Twitter.h>*/
#import "AppDelegate.h"
//#import "Preferiti.h"

//#import "Accounts/ACAccountStore.h"


//@interface DettaglioMessaggi : UIViewController<FBRequestDelegate, FBDialogDelegate, FBSessionDelegate>
@interface DettaglioMessaggi : UIViewController
{
  //  Facebook* _facebook;
    NSArray* _permissions;
    UIAlertView *objAlertView;
    IBOutlet UIButton *btnlogin;
    IBOutlet UIButton *btnpubblica;
    IBOutlet UIButton *btntweeter;
    IBOutlet UIImageView *btnpreferiti;
}
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

//@property (nonatomic, retain) IBOutlet UIWindow *window;

//@property (strong, nonatomic) Preferiti *currentPicture;
@property (nonatomic, retain) IBOutlet UIButton  *btnlogin;
@property (nonatomic, retain) IBOutlet UIButton  *btnpubblica;
@property (nonatomic, retain) IBOutlet UIButton  *btntweeter;
@property (nonatomic, retain) IBOutlet UIImageView *btnpreferiti;

//@property(readonly) Facebook *facebook;
@property (nonatomic, retain) NSMutableArray *_quickList;

-(void)publishStream:(id)sender;
-(void)loginToFacebook:(id)sender;
-(void)uploadFoto:(id)sender;
//-(void) carica;
//-(void) inserisci;
//-(void) cancella;

-(IBAction)Pubblica:(id)sender;
-(void)performTWRequestUpload;
-(IBAction)AggPreferito:(id)sender;
-(IBAction)TweetthisButtonClicked:(id)sender;
//-(IBAction)loginToFacebook:(id)sender;
-(IBAction)Pinch:(UIPinchGestureRecognizer *)recognizer;
-(IBAction)Candidati:(id)sender;;

/*@property (strong, nonatomic) NSArray *MessaggiDetailModel;
@property (strong, nonatomic) IBOutlet UILabel *makeLabel;
@property (strong, nonatomic) IBOutlet UILabel *modelLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextView *messaggioesteso;*/


@property (strong, nonatomic) NSArray *MessaggiDetailModel;
@property (nonatomic, strong) IBOutlet UILabel *link;
@property (nonatomic, strong) IBOutlet UILabel *company;
@property (nonatomic, strong) IBOutlet UILabel *job_title;
@property (nonatomic, strong) IBOutlet UILabel *location;
@property (nonatomic, strong) IBOutlet UILabel *loc_description;
@property (nonatomic, strong) IBOutlet UILabel *loc_address;
@property (nonatomic, strong) IBOutlet UILabel *summary;
@property (nonatomic, strong) IBOutlet UILabel *posting_date;
@property (nonatomic, strong) IBOutlet UILabel *closing_date;
@property (nonatomic, strong) IBOutlet UILabel *job_code;
@property (nonatomic, strong) IBOutlet UILabel *category;
@property (nonatomic, strong) IBOutlet UILabel *department;
@property (nonatomic, strong) IBOutlet UILabel *shift;
@property (nonatomic, strong) IBOutlet UILabel *education;
@property (nonatomic, strong) IBOutlet UILabel *pay_rate;
@property (nonatomic, strong) IBOutlet UILabel *pay_range;
@property (nonatomic, strong) IBOutlet UILabel *duration;
@property (nonatomic, strong) IBOutlet UILabel *travel;
@property (nonatomic, strong) IBOutlet UIWebView *job_description;
@property (nonatomic, strong) IBOutlet UIWebView *preferred_skills;
//@property (strong, nonatomic) ACAccountStore *accounts;


@end