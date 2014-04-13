//
//  CarTableViewController.h
//  MedjugorjeLite
//
//  Created by Guglielmo Puglia on 21/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lavori.h"

@interface MessaggiTableViewController  : UITableViewController{
IBOutlet UISegmentedControl *Segment;
    IBOutlet UILabel *LblAttesa;
    IBOutlet UIActivityIndicatorView *indicatore;
    BOOL storingCharacters;
    NSMutableString *contenutoTag;
    NSMutableArray *AnniMutableArray;
    NSMutableArray *AnniTotaleMutableArray;

}
@property (nonatomic, strong) NSArray *MessaggiImages;
@property (nonatomic, strong) NSArray *MessaggiMakes;
@property (nonatomic, strong) NSArray *MessaggiModels;
@property (nonatomic, strong) NSArray *MessaggiDataPubblicazione;
@property (nonatomic, strong) NSArray *MessaggiLink;

@property (nonatomic, strong) NSMutableArray *MessaggiImages1;
@property (nonatomic, strong) NSMutableArray *MessaggiMakes1;
@property (nonatomic, strong) NSMutableArray *MessaggiModels1;
@property (nonatomic, strong) NSMutableArray *MessaggiDataPubblicazione1;
@property (nonatomic, strong) NSMutableArray *MessaggiLink1;
 
@property (nonatomic, retain) IBOutlet UISegmentedControl *Segment;
@property (nonatomic, retain) IBOutlet UILabel  *LblAttesa;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Lavori *currentMessaggi;
@property (strong, nonatomic) NSMutableArray *MessaggiListData;
@property (nonatomic,retain) UIActivityIndicatorView *indicatore;
@property (nonatomic,retain) UIAlertView *alert;
@property (nonatomic, retain) NSMutableArray *AnniMutableArray;
@property (nonatomic, retain) NSMutableArray *AnniTotaleMutableArray;
@property (strong, nonatomic) NSMutableArray *NumUltimaPubblicazione;


-(IBAction)changeSeg;
- (BOOL)configurePersistentStoreCoordinatorForURL:(NSURL *)url ofType:(NSString *)fileType modelConfiguration:(NSString *)configuration storeOptions:(NSDictionary *)storeOptions error:(NSError **)error;


@end
