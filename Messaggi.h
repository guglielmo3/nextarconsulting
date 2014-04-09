//
//  Messaggi.h
//  MedjugorjeLite
//
//  Created by Guglielmo Puglia on 24/05/12.
//  Copyright (c) 2012 gugosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Messaggi : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * preferito;
@property (nonatomic, retain) NSData * smallpicture;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * anno;
@property (nonatomic, retain) NSNumber *prganno;

@end
