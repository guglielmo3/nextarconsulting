//
//  ContattaciMap.m
//  nextarconsulting
//
//  Created by Guglielmo Puglia on 04/05/14.
//  Copyright (c) 2014 Guglielmo Puglia. All rights reserved.
//

#import "ContattaciMap.h"

@implementation ContattaciMap

Parametri *parametri;


- (void)viewDidLoad
{
    [super viewDidLoad];
    _mapView.showsUserLocation = NO;
    _mapView.delegate = self;
    
    _mapView.mapType = MKMapTypeHybrid;
    [self LocationTorino];
    
}

- (IBAction)zoomIn:(id)sender {
    MKUserLocation *userLocation = _mapView.userLocation;
    MKCoordinateRegion region =
    MKCoordinateRegionMakeWithDistance (
                                        userLocation.location.coordinate, 20000, 20000);
    [_mapView setRegion:region animated:YES];
}

- (IBAction)changeMapType:(id)sender {
    if (_mapView.mapType == MKMapTypeStandard)
        _mapView.mapType = MKMapTypeSatellite;
    else
        _mapView.mapType = MKMapTypeStandard;
}

- (IBAction)setMapType:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            _mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            _mapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            _mapView.mapType = MKMapTypeHybrid;
            break;
        default:
            break;
    }
}
-(void) LocationTorino
{
    MKCoordinateRegion region;
    region.center.latitude = 45.034044;
    region.center.longitude =7.621535;
    region.span.latitudeDelta =0.112872;
    region.span.longitudeDelta = 0.109863;
    
    CLLocationCoordinate2D coord = {
        .latitude = region.center.latitude,
        .longitude = region.center.longitude};
    
    
     [_mapView setRegion:region animated:YES];
 
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = region.center;
    point.title = @"Torino";
    point.subtitle = @"Corso Orbassano 336";
    
    [self.mapView addAnnotation:point];
    
}

-(void) LocationRoma
{
    MKCoordinateRegion region;
    region.center.latitude = 41.890486;
    region.center.longitude =12.492231;
    region.span.latitudeDelta =0.112872;
    region.span.longitudeDelta = 0.109863;
    [_mapView setRegion:region animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = region.center;
    point.title = @"Roma";
    point.subtitle = @"Prossima Apertura";
    
    [self.mapView addAnnotation:point];
  
    
}
-(void) LocationUk
{
    MKCoordinateRegion region;
    region.center.latitude = 50.970755;
    region.center.longitude =-1.351444;
    region.span.latitudeDelta =0.112872;
    region.span.longitudeDelta = 0.109863;
    [_mapView setRegion:region animated:YES];
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = region.center;
    point.title = @"UK";
    point.subtitle = @"Wessex House Eastleigh";
    
    [self.mapView addAnnotation:point];

    
    
}
-(IBAction)Torino:(id)sender
{
    [self LocationTorino];
}

-(IBAction)Roma:(id)sender
{
    [self LocationRoma];
}

-(IBAction)Uk:(id)sender
{
    [self LocationUk];
}
-(IBAction)mail:(id)sender
{
        // This sample can run on devices running iPhone OS 2.0 or later
        // The MFMailComposeViewController class is only available in iPhone OS 3.0 or later.
        // So, we must verify the existence of the above class and provide a workaround for devices running
        // earlier versions of the iPhone OS.
        // We display an email composition interface if MFMailComposeViewController exists and the device can send emails.
        // We launch the Mail application on the device, otherwise.
    
        Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
        if (mailClass != nil)
        {
            // We must always check whether the current device is configured for sending emails
            if ([mailClass canSendMail])
            {
                [self displayComposerSheet];
            }
            else
            {
                [self launchMailAppOnDevice: (parametri.EmailContattaci)];

            }
        }
        else
        {
            [self launchMailAppOnDevice :(parametri.EmailContattaci)];
        }

}
-(void)displayComposerSheet
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:parametri.EmailSubject];
	
    
	// Set up recipients
	//NSArray *toRecipients = [NSArray arrayWithObject:@"info@SaverioGaeta.it"];
	NSArray *toRecipients = [NSArray arrayWithObject:parametri.SoloEmail];
	//NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    //	NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
	
	[picker setToRecipients:toRecipients];
    //	[picker setCcRecipients:ccRecipients];
    //	[picker setBccRecipients:bccRecipients];
	
	// Attach an image to the email
	//NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"png"];
    //NSData *myData = [NSData dataWithContentsOfFile:path];
	//[picker addAttachmentData:myData mimeType:@"image/png" fileName:@"rainy"];
	
	// Fill out the email body text
	NSString *emailBody = @"";
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
}
// Launches the Mail application on the device.
-(void)launchMailAppOnDevice :(NSString *) NSSreceipt
{
	NSString *recipients = parametri.EmailContattaci;
	NSString *body = @"&body=";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}
// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
			break;
		case MFMailComposeResultSent:
			break;
		case MFMailComposeResultFailed:
			break;
		default:
			break;
	}
    [self dismissViewControllerAnimated:NO completion:nil];
	//[self dismissModalViewControllerAnimated:YES];
}


@end
