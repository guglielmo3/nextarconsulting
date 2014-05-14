//
//  MessaggiTableViewCell.h
//  MedjugorjeLite
//
//  Created by Guglielmo Puglia on 21/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessaggiTableViewCell : UITableViewCell
/*
 @property (nonatomic, strong) IBOutlet UILabel *MessaggiImage;
@property (nonatomic, strong) IBOutlet UILabel *makeLabel;
@property (nonatomic, strong) IBOutlet UILabel *modelLabel;
@property (nonatomic, strong) IBOutlet UILabel *datapubb;
@property (nonatomic, strong) IBOutlet UILabel *luogo;
 */

@property (nonatomic, strong) IBOutlet UILabel *title;
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
@property (nonatomic, strong) IBOutlet UILabel *job_description;
@property (nonatomic, strong) IBOutlet UILabel *preferred_skills;


@end
