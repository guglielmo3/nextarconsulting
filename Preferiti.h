//
//  Pictures.h
//  MedjugorjeLite
//
//  Created by Guglielmo Puglia on 17/06/12.
//  Copyright (c) 2012 gugosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Preferiti: NSManagedObject

@property (nonatomic, retain) NSNumber * anno;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * prganno;
@property (nonatomic, retain) NSData * smallPicture;
@property (nonatomic, retain) NSString * title;

@end
