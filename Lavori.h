//
//  Lavori.h
//  nextarconsulting
//
//  Created by Guglielmo Puglia on 09/04/14.
//  Copyright (c) 2014 Guglielmo Puglia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Lavori : NSManagedObject

@property (nonatomic, retain) NSString * description_;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * permalink;
@property (nonatomic) NSTimeInterval pubDate;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * progressivo;

@end
