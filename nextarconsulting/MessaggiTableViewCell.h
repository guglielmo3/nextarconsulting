//
//  MessaggiTableViewCell.h
//  MedjugorjeLite
//
//  Created by Guglielmo Puglia on 21/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessaggiTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *MessaggiImage;
@property (nonatomic, strong) IBOutlet UILabel *makeLabel;
@property (nonatomic, strong) IBOutlet UILabel *modelLabel;
@property (nonatomic, strong) IBOutlet UILabel *datapubb;
@property (nonatomic, strong) IBOutlet UILabel *luogo;

@end
