//
//  MessaggiTableViewCell.m
//  MedjugorjeLite
//
//  Created by Guglielmo Puglia on 21/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MessaggiTableViewCell.h"

@implementation MessaggiTableViewCell
/*
@synthesize makeLabel = _makeLabel;
@synthesize modelLabel = _modelLabel;
@synthesize MessaggiImage = _MessaggiImage;
@synthesize datapubb = _datapubb;
@synthesize luogo = _luogo;
*/

@synthesize title = _title;
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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
