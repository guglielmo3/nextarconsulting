//
//  MessaggiTableViewCell.m
//  MedjugorjeLite
//
//  Created by Guglielmo Puglia on 21/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MessaggiTableViewCell.h"

@implementation MessaggiTableViewCell
@synthesize makeLabel = _makeLabel;
@synthesize modelLabel = _modelLabel;
@synthesize MessaggiImage = _MessaggiImage;
@synthesize datapubb = _datapubb;
@synthesize luogo = _luogo;

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
