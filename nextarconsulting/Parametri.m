//
//  Parametri.m
//  nextarconsulting
//
//  Created by Guglielmo Puglia on 14/05/14.
//  Copyright (c) 2014 Guglielmo Puglia. All rights reserved.
//

#import "Parametri.h"

@implementation Parametri

-(NSString *)Web_Service
{
    return @"http://nextar.co.uk/test/joomla3/index.php/jobgrok-premium/postings?format=app&type=rss";
}
-(NSString *)EmailContattaci
{
    return @"mailto:sales@nextarconsulting.com?subject=Contattaci - Nextar";
}
-(NSString *)EmailSubject
{
    return @"mailto:sales@nextarconsulting.com?subject=Contattaci - Nextar";
}
-(NSString *)SoloEmail
{
    return @"sales@nextarconsulting.com";
}
-(NSString *)IdApp
{
    return @"152139888244542";
}

@end
