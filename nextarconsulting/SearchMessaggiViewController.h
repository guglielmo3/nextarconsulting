//
//  SearchMessaggiViewController.h
//  MedjugorjeLite
//
//  Created by Guglielmo Puglia on 29/05/12.
//  Copyright (c) 2012 gugosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Messaggi.h"
#import "Lavori.h"

@interface SearchMessaggiViewController : UITableViewController<UISearchBarDelegate,UISearchDisplayDelegate> {
    IBOutlet UISearchBar *searchbar;
}
@property (nonatomic, strong) NSArray *MessaggiImages;
@property (nonatomic, strong) NSArray *MessaggiMakes;
@property (nonatomic, strong) NSArray *MessaggiModels;
@property (nonatomic, retain) IBOutlet UISegmentedControl *Segment;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Lavori *currentMessaggi;
@property (strong, nonatomic) NSMutableArray *MessaggiListData;
@property (nonatomic, retain) IBOutlet UISearchBar  *searchbar;




@end
