//
//  CampiVisibili.h
//  nextarconsulting
//
//  Created by Guglielmo Puglia on 12/05/14.
//  Copyright (c) 2014 Guglielmo Puglia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CampiVisibili : NSManagedObject

@property (nonatomic, retain) NSNumber * category;
@property (nonatomic, retain) NSNumber * closing_date;
@property (nonatomic, retain) NSNumber * company;
@property (nonatomic, retain) NSNumber * department;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSNumber * education;
@property (nonatomic, retain) NSNumber * job_code;
@property (nonatomic, retain) NSNumber * job_description;
@property (nonatomic, retain) NSNumber * job_title;
@property (nonatomic, retain) NSNumber * link;
@property (nonatomic, retain) NSNumber * loc_address;
@property (nonatomic, retain) NSNumber * loc_description;
@property (nonatomic, retain) NSNumber * location;
@property (nonatomic, retain) NSNumber * pay_range;
@property (nonatomic, retain) NSNumber * pay_rate;
@property (nonatomic, retain) NSNumber * posting_date;
@property (nonatomic, retain) NSNumber * preferred_skills;
@property (nonatomic, retain) NSNumber * progressivo;
@property (nonatomic, retain) NSNumber * shift;
@property (nonatomic, retain) NSNumber * summary;
@property (nonatomic, retain) NSNumber * title;
@property (nonatomic, retain) NSNumber * travel;

@end
