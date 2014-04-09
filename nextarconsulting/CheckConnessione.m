//
//  CheckConnessione.m
//  MedjugorjeLite
//
//  Created by Guglielmo Puglia on 04/06/12.
//  Copyright (c) 2012 gugosoft. All rights reserved.
//

#import "CheckConnessione.h"
#import "Reachability.h"

@implementation CheckConnessione

-(BOOL)eseguiControllo {
    
    internetReach = [Reachability reachabilityForInternetConnection];
    if ([self check:internetReach]) {
        return true;
    }
    
    wifiReach = [Reachability reachabilityForLocalWiFi];
    return  [self check:wifiReach];
}

-(BOOL)check:(Reachability*) curReach{
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    
    switch (netStatus){
        case NotReachable:{
            return false;
            //return true;
            break;
        }
        case ReachableViaWWAN:{
            return true;
            break;
        }
        case ReachableViaWiFi:{
            return true;
            break;
        }
    }
}
@end
