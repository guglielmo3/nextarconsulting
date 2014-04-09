//
//  CheckConnessione.h
//  MedjugorjeLite
//
//  Created by Guglielmo Puglia on 04/06/12.
//  Copyright (c) 2012 gugosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Reachability;


@interface CheckConnessione : NSObject{
Reachability* internetReach;
Reachability* wifiReach;
}

-(BOOL)eseguiControllo;
-(BOOL)check:(Reachability*) curReach;


@end
