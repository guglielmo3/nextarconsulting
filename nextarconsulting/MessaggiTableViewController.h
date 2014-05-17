//
//  CarTableViewController.h
//  MedjugorjeLite
//
//  Created by Guglielmo Puglia on 21/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Lavori.h"
#import "LavoriCompleta.h"
#import "CampiVisibili.h"

@interface MessaggiTableViewController  : UITableViewController<UISearchBarDelegate,UISearchDisplayDelegate>{
//IBOutlet UISegmentedControl *Segment;
//    IBOutlet UILabel *LblAttesa;
//    IBOutlet UIActivityIndicatorView *indicatore;
    BOOL storingCharacters;
    NSMutableString *contenutoTag;
    NSMutableArray *AnniMutableArray;
    NSMutableArray *AnniTotaleMutableArray;
    IBOutlet UISearchBar *searchbar;

}
/*@property (nonatomic, strong) NSArray *MessaggiImages;
@property (nonatomic, strong) NSArray *MessaggiMakes;
@property (nonatomic, strong) NSArray *MessaggiModels;
@property (nonatomic, strong) NSArray *MessaggiDataPubblicazione;
 @property (nonatomic, strong) NSArray *MessaggiLink;
 */

@property (nonatomic, strong) NSArray *Messaggititle;
@property (nonatomic, strong) NSArray *Messaggilink;
@property (nonatomic, strong) NSArray *Messaggicompany;
@property (nonatomic, strong) NSArray *Messaggijob_title;
@property (nonatomic, strong) NSArray *Messaggilocation;
@property (nonatomic, strong) NSArray *Messaggiloc_description;
@property (nonatomic, strong) NSArray *Messaggiloc_address;
@property (nonatomic, strong) NSArray *Messaggisummary;
@property (nonatomic, strong) NSArray *Messaggiposting_date;
@property (nonatomic, strong) NSArray *Messaggiclosing_date;
@property (nonatomic, strong) NSArray *Messaggijob_code;
@property (nonatomic, strong) NSArray *Messaggicategory;
@property (nonatomic, strong) NSArray *Messaggidepartment;
@property (nonatomic, strong) NSArray *Messaggishift;
@property (nonatomic, strong) NSArray *Messaggieducation;
@property (nonatomic, strong) NSArray *Messaggipay_rate;
@property (nonatomic, strong) NSArray *Messaggipay_range;
@property (nonatomic, strong) NSArray *Messaggiduration;
@property (nonatomic, strong) NSArray *Messaggitravel;
@property (nonatomic, strong) NSArray *Messaggijob_description;
@property (nonatomic, strong) NSArray *Messaggipreferred_skills;





/*@property (nonatomic, strong) NSMutableArray *MessaggiImages1;
@property (nonatomic, strong) NSMutableArray *MessaggiMakes1;
@property (nonatomic, strong) NSMutableArray *MessaggiModels1;
@property (nonatomic, strong) NSMutableArray *MessaggiDataPubblicazione1;
 */
//@property (nonatomic, strong) NSMutableArray *MessaggiLink1;

@property (nonatomic, strong) NSMutableArray *Messaggititle1;
@property (nonatomic, strong) NSMutableArray *Messaggilink1;
@property (nonatomic, strong) NSMutableArray *Messaggicompany1;
@property (nonatomic, strong) NSMutableArray *Messaggijob_title1;
@property (nonatomic, strong) NSMutableArray *Messaggilocation1;
@property (nonatomic, strong) NSMutableArray *Messaggiloc_description1;
@property (nonatomic, strong) NSMutableArray *Messaggiloc_address1;
@property (nonatomic, strong) NSMutableArray *Messaggisummary1;
@property (nonatomic, strong) NSMutableArray *Messaggiposting_date1;
@property (nonatomic, strong) NSMutableArray *Messaggiclosing_date1;
@property (nonatomic, strong) NSMutableArray *Messaggijob_code1;
@property (nonatomic, strong) NSMutableArray *Messaggicategory1;
@property (nonatomic, strong) NSMutableArray *Messaggidepartment1;
@property (nonatomic, strong) NSMutableArray *Messaggishift1;
@property (nonatomic, strong) NSMutableArray *Messaggieducation1;
@property (nonatomic, strong) NSMutableArray *Messaggipay_rate1;
@property (nonatomic, strong) NSMutableArray *Messaggipay_range1;
@property (nonatomic, strong) NSMutableArray *Messaggiduration1;
@property (nonatomic, strong) NSMutableArray *Messaggitravel1;
@property (nonatomic, strong) NSMutableArray *Messaggijob_description1;
@property (nonatomic, strong) NSMutableArray *Messaggipreferred_skills1;

 
//@property (nonatomic, retain) IBOutlet UISegmentedControl *Segment;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) LavoriCompleta *currentLavoriCompleta;
@property (strong, nonatomic) CampiVisibili *currentCampiVisibili;

@property (strong, nonatomic) NSMutableArray *MessaggiListData;
//@property (nonatomic,retain) UIActivityIndicatorView *indicatore;
@property (nonatomic,retain) UIAlertView *alert;
@property (nonatomic, retain) NSMutableArray *AnniMutableArray;
@property (nonatomic, retain) NSMutableArray *AnniTotaleMutableArray;
//@property (strong, nonatomic) NSMutableArray *NumUltimaPubblicazione;
@property (nonatomic, retain) IBOutlet UISearchBar  *searchbar;


-(IBAction)changeSeg;
- (BOOL)configurePersistentStoreCoordinatorForURL:(NSURL *)url ofType:(NSString *)fileType modelConfiguration:(NSString *)configuration storeOptions:(NSDictionary *)storeOptions error:(NSError **)error;


@end
