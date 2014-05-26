//
//  DettaglioMessaggi.m
//  MedjugorjeLite
//
//  Created by Guglielmo Puglia on 21/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DettaglioMessaggi.h"
#import "CheckConnessione.h"
#import "CoreDataHelper.h"
#import "Parametri.h"



//static NSString* kAppId = @"311313092281732";



@interface DettaglioMessaggi ()
{
}
@end
//@implementation AppDelegate
Parametri *parametri;

@implementation DettaglioMessaggi

/*@synthesize makeLabel = _makeLabel;
@synthesize modelLabel = _modelLabel;
@synthesize imageView = _imageView;


@synthesize messaggioesteso = _messaggioesteso;*/
@synthesize MessaggiDetailModel = _MessaggiDetailModel;

@synthesize link = _link;
@synthesize company = _company;
@synthesize job_title = _job_title;
@synthesize location = _location;
@synthesize loc_description = _loc_description;
@synthesize loc_address = _loc_address;
@synthesize summary = _summary;
@synthesize posting_date = _posting_date;
@synthesize closing_date = _closing_date;
@synthesize job_code = _job_code;
@synthesize category = _category;
@synthesize department = _department;
@synthesize shift = _shift;
@synthesize education = _education;
@synthesize pay_rate = _pay_rate;
@synthesize pay_range = _pay_range;
@synthesize duration = _duration;
@synthesize travel = _travel;
@synthesize job_description = _job_description;
@synthesize preferred_skills = _preferred_skills;

//@synthesize facebook;
//@synthesize managedObjectContext = _managedObjectContext;
@synthesize  _quickList;
@synthesize managedObjectContext;
//@synthesize currentPicture;
@synthesize btnlogin;
@synthesize btntweeter;
@synthesize btnpubblica;
@synthesize btnpreferiti;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (managedObjectContext == nil) 
	{ 
        managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
        NSLog(@"After managedObjectContext_: %@",  managedObjectContext);
	}
    
    self.view.backgroundColor = [UIColor whiteColor];
   // NSPredicate *pred = [NSPredicate predicateWithFormat:@"(progressivo == %@ )", [self.MessaggiDetailModel objectAtIndex:2]];
  /*  if ([CoreDataHelper countForEntity:@"Preferiti"  withPredicate:pred andContext:managedObjectContext] == 1) {
        btnpreferiti.hidden = false;
    }
    else {*/
        btnpreferiti.hidden = true;
    //}
 
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
  //  [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *DataConvert;
    NSString *result;
    
   self.job_title.text = [self.MessaggiDetailModel objectAtIndex:0];
    self.job_code.text = [self.MessaggiDetailModel objectAtIndex:1];
 
 /*   NSString *result = [NSString stringWithFormat:@"%@", [self.MessaggiDetailModel objectAtIndex:0]];
    [self.job_title loadHTMLString:result baseURL:nil];
  
    result = [NSString stringWithFormat:@"%@", [self.MessaggiDetailModel objectAtIndex:1]];
    [self.job_code loadHTMLString:result baseURL:nil];*/

    DataConvert =[self.MessaggiDetailModel objectAtIndex:2];
  //  result = [NSString stringWithFormat:@"%@", DataConvert];
   // [self.posting_date loadHTMLString:result baseURL:nil];
     self.posting_date.text = [dateFormatter stringFromDate:[self.MessaggiDetailModel objectAtIndex:2]];
    
    DataConvert =[self.MessaggiDetailModel objectAtIndex:3];
   // result = [NSString stringWithFormat:@"%@", DataConvert];
    //[self.closing_date loadHTMLString:result baseURL:nil];
    self.closing_date.text = [dateFormatter stringFromDate:[self.MessaggiDetailModel objectAtIndex:3]];
    
    //result = [NSString stringWithFormat:@"%@", [self.MessaggiDetailModel objectAtIndex:4]];
 //  [self.category loadHTMLString:result baseURL:nil];
     self.category.text = [self.MessaggiDetailModel objectAtIndex:4];
   
    //result = [NSString stringWithFormat:@"%@", [self.MessaggiDetailModel objectAtIndex:5]];
   //[self.department loadHTMLString:result baseURL:nil];
    self.department.text = [self.MessaggiDetailModel objectAtIndex:5];
    
    self.location.text= [self.MessaggiDetailModel objectAtIndex:6];
    //result = [NSString stringWithFormat:@"%@", [self.MessaggiDetailModel objectAtIndex:11]];
  //[self.location loadHTMLString:result baseURL:nil];
    self.loc_description.text= [self.MessaggiDetailModel objectAtIndex:14];
    self.loc_address.text= [self.MessaggiDetailModel objectAtIndex:15];
    
    //result = [NSString stringWithFormat:@"%@", [self.MessaggiDetailModel objectAtIndex:8]];
   //[self.education loadHTMLString:result baseURL:nil];
    self.education.text=[self.MessaggiDetailModel objectAtIndex:8];
    
    //result = [NSString stringWithFormat:@"%@", [self.MessaggiDetailModel objectAtIndex:9]];
   //[self.duration loadHTMLString:result baseURL:nil];
    self.duration.text=[self.MessaggiDetailModel objectAtIndex:9];
 
    //result = [NSString stringWithFormat:@"%@", [self.MessaggiDetailModel objectAtIndex:10]];
    //[self.travel loadHTMLString:result baseURL:nil];
    self.travel.text =[self.MessaggiDetailModel objectAtIndex:10];

    
     result = [NSString stringWithFormat:@"%@", [self.MessaggiDetailModel objectAtIndex:11]];
    
    //self.job_description.text = result;
    [self.job_description loadHTMLString:result baseURL:nil];
    
    result = [NSString stringWithFormat:@"%@", [self.MessaggiDetailModel objectAtIndex:13]];
    
    [self.preferred_skills loadHTMLString:result baseURL:nil];
    
    
    
    
}


-(IBAction)Candidati:(id)sender
{
			[self launchMailAppOnDevice];

}

-(void)launchMailAppOnDevice
{
	NSString *recipients = [self.MessaggiDetailModel objectAtIndex:12];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:recipients]];
}



-(IBAction)loginToFacebook:(id)sender
{
    BOOL controllo;
    controllo = [[CheckConnessione alloc] eseguiControllo];
    if (controllo) {
   //     _facebook = [[Facebook alloc] initWithAppId:kAppId];
     //   [_facebook authorize:_permissions delegate:self];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Spiacente" message:@"Non sono presenti connessioni internet attive al momento, riprovare più tardi." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
    }
}

-(void)fbDidLogin
{
    NSLog(@"utente loggato");
    
    btnlogin.hidden = true;
    btnpubblica.hidden = false;
}

-(void)fbDidLogout
{
    NSLog(@"utente sloggato");
    btnlogin.hidden = false;
    btnpubblica.hidden = true;
}
-(void)fbDidNotLogin:(BOOL)cancelled
{
    NSLog(@"login non riuscito");
}

/*
-(void)publishStream:(id)sender
{
    SBJSON *jsonWriter = [SBJSON new] ;
	
    //link del post
	NSDictionary* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys: 
														   @"MedjugorjeLite",@"text", //nome link
														   @"http://www.cavalieridellaluce.net/",@"href", //collegamento link
														   nil], nil];
	
	
	NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
	
    //immmagine post
	NSDictionary* media = [NSDictionary dictionaryWithObjectsAndKeys:
						   @"image", @"type", //tipo di media allegato (immagine)
						   @"http://www.cavalieridellaluce.net/wp-content/themes/dusk/images/logo.png", @"src", //link dell'immagine
						   @"http://www.cavalieridellaluce.net/", @"href", nil]; //link a cui porta l'immagine se cliccata
	NSArray * arraymedia = [NSArray arrayWithObject:media];
	
	NSUInteger characterCount = [self.messaggioesteso.text length];
    if (characterCount > 1000) {
        characterCount = 1000;
    }
	
	//collegamenti dell'immagine del post
	NSDictionary* attachment = [NSDictionary dictionaryWithObjectsAndKeys:
								self.makeLabel.text, @"name", //nome che compare vicino all'immagine
								arraymedia, @"media",
								[self.messaggioesteso.text substringWithRange:NSMakeRange(0, characterCount)] , @"caption", //caption (parte in piccolo sotto l'iconcina della nostra app
								@"http://www.cavalieridellaluce.net/", @"href", nil];//link a cui porta caption
	
	NSString *attachmentStr = [jsonWriter stringWithObject:attachment];
	
	
    //parametri post
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   kAppId, @"api_key", //chiave api
								   @"Share on Facebook",  @"user_message_prompt", //default. Si può modificare ma non ha rilievo per il post
								   @"Medjugorje, i messaggi - la storia", @"message", //messaggio di post (è l'unica cosa che l'utente può modificare prima del post)
								   actionLinksStr, @"action_links",
								   attachmentStr, @"attachment",
								   nil];    
    
  	[_facebook dialog: @"stream.publish"
            andParams: params
          andDelegate:self]; 
}

-(void)uploadFoto:(id)sender
{
    NSString *path = @"http://www.devapp.it/wordpress/wp-content/uploads/logo_devAPP.png";
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img  = [[UIImage alloc] initWithData:data];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   img, @"picture",
                                   nil];
    
    [_facebook requestWithGraphPath:@"me/photos"
                          andParams:params
                      andHttpMethod:@"POST"
                        andDelegate:self];
    
  //  [img release];
}
-(IBAction)TweetthisButtonClicked:(id)sender{
    
    //first identify whether the device has twitter framework or not
    if (NSClassFromString(@"TWTweetComposeViewController")) {
        
        NSLog(@"Twitter framework is available on the device");
        //code goes here
        //create the object of the TWTweetComposeViewController
        TWTweetComposeViewController *twitterComposer = [[TWTweetComposeViewController alloc]init];
        //set the text that you want to post
        NSString *app = [self.MessaggiDetailModel objectAtIndex:1];
        [twitterComposer setInitialText: [app substringToIndex:140]];
        [twitterComposer setTitle:[self.MessaggiDetailModel objectAtIndex:0]];
        
        
        //add Image
        //[twitterComposer addImage:[UIImage imageNamed:@"apple1.png"]];
        
        //add Link
        // [twitterComposer addURL:[NSURL URLWithString:@"http://iphonebyradix.blogspot.in"]];
        
        //display the twitter composer modal view controller
        [self presentModalViewController:twitterComposer animated:YES];
        
        //check to update the user regarding his tweet
        twitterComposer.completionHandler = ^(TWTweetComposeViewControllerResult res){
            
            //if the posting is done successfully
            if (res == TWTweetComposeViewControllerResultDone){
                objAlertView = [[UIAlertView alloc]initWithTitle:@"Twitter" message:@"Tweet Pubblicato" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [objAlertView show];
            } 
            //if posting is done unsuccessfully
            else if(res==TWTweetComposeViewControllerResultCancelled){
                objAlertView = [[UIAlertView alloc]initWithTitle:@"Attenzione" message:@"Tweet non Pubblicato" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [objAlertView show];
            }
            //dismiss the twitter modal view controller.
            [self dismissModalViewControllerAnimated:YES];
        };
        
        
        
        
    }else{
        NSLog(@"Twitter framework is not available on the device");
        
        objAlertView = [[UIAlertView alloc]initWithTitle:@"Attenzione" message:@"Il tuo device non può mandare al momento tweet, Controlla per favore la presenza della connessione internet o le impostazioni del tuo account twitter" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [objAlertView show];
        
    }
}



-(IBAction)Pubblica:(id)sender
{
   // _facebook = [[Facebook alloc] initWithAppId:kAppId andDelegate:self];
   // [_facebook authorize:_permissions];
    // Create the item to share (in this example, a url)
    [self publishStream:sender];
}

- (void)performTWRequestUpload
{
    NSURL *url = 
    [NSURL URLWithString:
     @"https://upload.twitter.com/1/statuses/update_with_media.json"];
    
    //  Create a POST request for the target endpoint
    TWRequest *request = 
    [[TWRequest alloc] initWithURL:url 
                        parameters:nil 
                     requestMethod:TWRequestMethodPOST];
    
    //  self.accounts is an array of all available accounts; 
    //  we use the first one for simplicity
    //[request setAccount:[self.accounts objectAtIndex:0]];
    
    //  The "larry.png" is an image that we have locally
    UIImage *image = [UIImage imageNamed:@"larry.png"];
    
    //  Obtain NSData from the UIImage 
    NSData *imageData = UIImagePNGRepresentation(image);
    
    //  Add the data of the image with the 
    //  correct parameter name, "media[]"
    [request addMultiPartData:imageData 
                     withName:@"media[]" 
                         type:@"multipart/form-data"];
    
    // NB: Our status must be passed as part of the multipart form data
    NSString *status = @"just setting up my twttr #iOS5";
    
    //  Add the data of the status as parameter "status"
    [request addMultiPartData:[status dataUsingEncoding:NSUTF8StringEncoding] 
                     withName:@"status" 
                         type:@"multipart/form-data"];
    
    //  Perform the request.  
    //    Note that -[performRequestWithHandler] may be called on any thread,
    //    so you should explicitly dispatch any UI operations to the main thread 
    [request performRequestWithHandler:
     ^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
         NSDictionary *dict = 
         (NSDictionary *)[NSJSONSerialization 
                          JSONObjectWithData:responseData options:0 error:nil];
         
         // Log the result
         NSLog(@"%@", dict);
         
         dispatch_async(dispatch_get_main_queue(), ^{
             // perform an action that updates the UI...
         });
     }];
}
 */

/*
-(IBAction)AggPreferito:(id)sender
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(title == %@ )", [self.MessaggiDetailModel objectAtIndex:0]];
    if ([CoreDataHelper countForEntity:@"Preferiti" withPredicate:pred andContext:managedObjectContext] == 0)
    {    

    // If we are adding a new picture (because we didnt pass one from the table) then create an entry
    self.currentPicture = (Preferiti *)[NSEntityDescription insertNewObjectForEntityForName:@"Preferiti" inManagedObjectContext:self.managedObjectContext];
    
    // For both new and existing pictures, fill in the details from the form
    [self.currentPicture setTitle:[self.MessaggiDetailModel objectAtIndex:0]];
    [self.currentPicture setDesc:[self.MessaggiDetailModel objectAtIndex:1]];
    
    if (self.imageView.image)
    {
        // Resize and save a smaller version for the table
        float resize = 74.0;
        float actualWidth = self.imageView.image.size.width;
        float actualHeight = self.imageView.image.size.height;
        float divBy, newWidth, newHeight;
        if (actualWidth > actualHeight) {
            divBy = (actualWidth / resize);
            newWidth = resize;
            newHeight = (actualHeight / divBy);
        } else {
            divBy = (actualHeight / resize);
            newWidth = (actualWidth / divBy);
            newHeight = resize;
        }
        CGRect rect = CGRectMake(0.0, 0.0, newWidth, newHeight);
        UIGraphicsBeginImageContext(rect.size);
        [self.imageView.image drawInRect:rect];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // Save the small image version
        NSData *smallImageData = UIImageJPEGRepresentation(smallImage, 1.0);
        [self.currentPicture setSmallPicture:smallImageData];
    }
    
    //  Commit item to core data
    NSError *error;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Errore nel salvataggio dei dati: %@", [error domain]);
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aggiunta Preferiti"
														message:@"Messaggio Aggiunto alla lista dei preferiti"
													   delegate:self
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		[alert show];
	    btnpreferiti.hidden = false;
    }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aggiunta Preferiti"
														message:@"Messaggio già presente nella lista dei preferiti."
													   delegate:self
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		[alert show];

    }

}
*/


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
-(IBAction)Pinch:(UIPinchGestureRecognizer *)recognizer;
{
    NSLog(@"Action: Two fingers, two taps");
    int app = [(UIPinchGestureRecognizer *) recognizer scale];
   // self.messaggioesteso.font =[UIFont fontWithName:@"System" size: app + 14];
 
   
 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return TRUE;
}

@end
