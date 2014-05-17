//
//  ContattaciMap.h
//  nextarconsulting
//
//  Created by Guglielmo Puglia on 04/05/14.
//  Copyright (c) 2014 Guglielmo Puglia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "Parametri.h"


@interface ContattaciMap : UIViewController <MKMapViewDelegate,MFMailComposeViewControllerDelegate>


@property (strong, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)zoomIn:(id)sender;
- (IBAction)changeMapType:(id)sender;
- (IBAction)Torino:(id)sender;
- (IBAction)Roma:(id)sender;
- (IBAction)Uk:(id)sender;
- (IBAction)mail:(id)sender;
-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;

@end