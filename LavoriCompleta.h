//
//  LavoriCompleta.h
//  nextarconsulting
//
//  Created by Guglielmo Puglia on 12/05/14.
//  Copyright (c) 2014 Guglielmo Puglia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LavoriCompleta : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * job_title;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * loc_description;
@property (nonatomic, retain) NSString * loc_address;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSDate * posting_date;
@property (nonatomic, retain) NSDate * closing_date;
@property (nonatomic, retain) NSString * job_code;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * department;
@property (nonatomic, retain) NSString * shift;
@property (nonatomic, retain) NSString * education;
@property (nonatomic, retain) NSString * pay_rate;
@property (nonatomic, retain) NSString * pay_range;
@property (nonatomic, retain) NSString * duration;
@property (nonatomic, retain) NSString * travel;
@property (nonatomic, retain) NSString * job_description;
@property (nonatomic, retain) NSString * preferred_skills;
@property (nonatomic, retain) NSNumber * progressivo;

@end
