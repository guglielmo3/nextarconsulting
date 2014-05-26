//
//  AggiornaMessaggi.m
//  nextarconsulting
//
//  Created by Guglielmo Puglia on 03/05/14.
//  Copyright (c) 2014 Guglielmo Puglia. All rights reserved.
//

#import "AggiornaMessaggi.h"
#import "CoreDataHelper.h"
#import "LavoriCompleta.h"
#import "Parametri.h"

@implementation AggiornaMessaggi

NSString *tipoRichiesta;
NSString *caricaDatiAggiorna = @"0";
NSString *locationVar =@"0";

-(BOOL) AggiornaDati
{
    caricaDatiAggiorna = @"0";
    locationVar= @"0";
    if (_managedObjectContext == nil)
	{
        _managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        NSLog(@"After managedObjectContext_: %@",  _managedObjectContext);
	}
    
    AnniMutableArray = [[NSMutableArray alloc] init];
    AnniTotaleMutableArray = [[NSMutableArray alloc] init];
    _Messaggicategory = [[NSMutableArray alloc] init];
    _Messaggiclosing_date  = [[NSMutableArray alloc] init];
    _Messaggicompany = [[NSMutableArray alloc] init];
    _Messaggidepartment = [[NSMutableArray alloc] init];
    _Messaggiduration = [[NSMutableArray alloc] init];
    _Messaggieducation = [[NSMutableArray alloc] init];
    _Messaggijob_code = [[NSMutableArray alloc] init];
    _Messaggijob_description = [[NSMutableArray alloc] init];
    _Messaggijob_title = [[NSMutableArray alloc] init];
    _Messaggilink = [[NSMutableArray alloc] init];
    _Messaggiloc_address = [[NSMutableArray alloc] init];
    _Messaggiloc_description = [[NSMutableArray alloc] init];
    _Messaggilocation = [[NSMutableArray alloc] init];
    _Messaggipay_range = [[NSMutableArray alloc] init];
    _Messaggipay_rate = [[NSMutableArray alloc] init];
    _Messaggiposting_date = [[NSMutableArray alloc] init];
    _Messaggipreferred_skills = [[NSMutableArray alloc] init];
    _Messaggishift = [[NSMutableArray alloc] init];
    _Messaggisummary = [[NSMutableArray alloc] init];
    _Messaggititle = [[NSMutableArray alloc] init];
    _Messaggitravel = [[NSMutableArray alloc] init];
    contenutoTag = [[NSMutableString alloc] init];

    
    
   /* UIAlertView *alert;
    alert = [[UIAlertView alloc] initWithTitle:@"Attendere"
                                       message:@"Download e Installazione ultime Offerte"
                                      delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [indicator startAnimating];
    [alert addSubview:indicator];
    
    indicator.center = CGPointMake(140, 90);
    
    int n = 0;
    while (n<50)
    {
        [[NSRunLoop currentRunLoop] limitDateForMode:NSDefaultRunLoopMode];
        [NSThread sleepForTimeInterval:0.001];
        n++;
    }
    */
    Parametri *web_service = [Parametri alloc];
    
    
    NSString *path = web_service.Web_Service;
    NSURL *url = [NSURL URLWithString:path];
    NSXMLParser *parser =[[NSXMLParser alloc] initWithContentsOfURL:url];
    tipoRichiesta = @"rss";
    [parser setDelegate:self];
    [parser parse];
    int app0 = self.AnniMutableArray.count;
    int ciclo0 = 0;
    
    int tempNum;
    
    
    [ CoreDataHelper deleteAllObjectsForEntity:@"LavoriCompleta" withPredicate:nil andContext:_managedObjectContext];
    
    
    
    [self gestiscidaticore];
    
    
    
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    
    /*
     UILocalNotification *localNotification = [[UILocalNotification alloc]init];
     [localNotification setApplicationIconBadgeNumber:0];
     */
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
  //  [alert dismissWithClickedButtonIndex:0 animated:true];
    
	// Do any additional setup after loading the view, typically from a nib.
    return  true;

}
-(void) gestiscidaticore
{
    
    [CoreDataHelper deleteAllObjectsForEntity:@"LavoriCompleta" withPredicate:nil andContext:_managedObjectContext];
    
    int app0 = self.Messaggijob_title.count;
    int ciclo0 = 0;
    
    while (ciclo0 <= (app0 -1)) {
        self.currentMessaggi = (LavoriCompleta *)[NSEntityDescription insertNewObjectForEntityForName:@"LavoriCompleta" inManagedObjectContext:self.managedObjectContext];
        
        // For both new and existing pictures, fill in the details from the form
        NSNumber *prganno = [NSNumber numberWithInt:ciclo0];
        
        [self.currentMessaggi setProgressivo:prganno];
        [self.currentMessaggi setJob_title:[self.Messaggijob_title objectAtIndex:ciclo0]];
        [self.currentMessaggi setJob_description:[self.Messaggijob_description objectAtIndex:ciclo0]];
        [self.currentMessaggi setLink:[self.Messaggilink objectAtIndex:ciclo0]];
        [self.currentMessaggi setPosting_date:[self.Messaggiposting_date objectAtIndex:ciclo0]];
        [self.currentMessaggi setCategory:[self.Messaggicategory objectAtIndex:ciclo0]];
        
        
        //Riempio gli array con il contenuto della cella
        [self.currentMessaggi setClosing_date:[self.Messaggiclosing_date  objectAtIndex:ciclo0]];
        [self.currentMessaggi setCompany:[self.Messaggicompany  objectAtIndex:ciclo0]];
        [self.currentMessaggi setDepartment:[self.Messaggidepartment  objectAtIndex:ciclo0]];
        [self.currentMessaggi setDuration:[self.Messaggiduration  objectAtIndex:ciclo0]];
        [self.currentMessaggi setEducation:[self.Messaggieducation  objectAtIndex:ciclo0]];
        [self.currentMessaggi setJob_code:[self.Messaggijob_code  objectAtIndex:ciclo0]];
        [self.currentMessaggi setJob_description:[self.Messaggijob_description  objectAtIndex:ciclo0]];
        [self.currentMessaggi setLoc_address:[self.Messaggiloc_address  objectAtIndex:ciclo0]];
        [self.currentMessaggi setLoc_description:[self.Messaggiloc_description  objectAtIndex:ciclo0]];
        [self.currentMessaggi setLocation:[self.Messaggilocation  objectAtIndex:ciclo0]];
        [self.currentMessaggi setPay_range:[self.Messaggipay_range  objectAtIndex:ciclo0]];
        [self.currentMessaggi setPay_rate:[self.Messaggipay_rate  objectAtIndex:ciclo0]];
        [self.currentMessaggi setPosting_date:[self.Messaggiposting_date  objectAtIndex:ciclo0]];
        [self.currentMessaggi setPreferred_skills:[self.Messaggipreferred_skills  objectAtIndex:ciclo0]];
        [self.currentMessaggi setShift:[self.Messaggishift  objectAtIndex:ciclo0]];
        [self.currentMessaggi setSummary:[self.Messaggisummary  objectAtIndex:ciclo0]];
        [self.currentMessaggi setTitle:[self.Messaggititle  objectAtIndex:ciclo0]];
        [self.currentMessaggi setTravel:[self.Messaggitravel  objectAtIndex:ciclo0]];

        ciclo0 = ciclo0 +1;
        //  Commit item to core data
        NSError *error;
        if (![self.managedObjectContext save:&error])
            NSLog(@"Failed to add new picture with error: %@", [error domain]);
    }
    
    
    
    
}

-(void) parser: (NSXMLParser *) parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"errore");
    /*   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Spiacente" message:@"Servizio di aggiornamento non disponibile al momento" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
     [alertView show];  */
    
}
-(void) parserDidEndDocument:(NSXMLParser *) parser
{
    NSLog(@"Parsing finito");
}
-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"Inizio Tag%@",elementName);
    storingCharacters = YES;
}

-(void) parser:(NSXMLParser *) parser foundCharacters:(NSString *)string
{
    if (storingCharacters) [contenutoTag appendString:string];
    
}
-(void) parser:(NSXMLParser *) parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSString *immutableString = [NSString stringWithString:contenutoTag];
    
    NSRange r;
    
  /*
    if ([tipoRichiesta isEqualToString:@"atom"])
    {
        
        if([elementName isEqualToString:@"entry"])
        {
            caricaDatiAggiorna = @"1";
        }
        
        if([caricaDatiAggiorna isEqualToString:@"1"])
        {
            if ([elementName isEqualToString:@"title"]) {
                while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                    immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];
                NSString* noWhiteSpace =  [immutableString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                noWhiteSpace =[ noWhiteSpace stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                
                [_MessaggiMakes addObject:noWhiteSpace];
            }
            
            if ([elementName isEqualToString:@"content"]) {
                while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                    immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];
                
                [_MessaggiModels addObject:immutableString];
            }
            
            if ([elementName isEqualToString:@"link"]) {
                [_MessaggiImages addObject:immutableString];
            }
            
            if ([elementName isEqualToString:@"published"])
            {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                // this is imporant - we set our input date format to match our input string
                // if format doesn't match you'll get nil from your string, so be careful
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *dateFromString = [[NSDate alloc] init];
                // voila!
                NSString *value = [immutableString substringWithRange:NSMakeRange(0, 10)];
                dateFromString = [dateFormatter dateFromString:value];
                [_MessaggiDataPubblicazione addObject:dateFromString];
                
            }
            
        }
    }
    else
    {
        if([elementName isEqualToString:@"item"])
        {
            caricaDatiAggiorna = @"1";
        }
        
        if([caricaDatiAggiorna isEqualToString:@"1"])
        {
            if ([elementName isEqualToString:@"title"]) {
                while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                    immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];
                NSString* noWhiteSpace =  [immutableString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                noWhiteSpace =[ noWhiteSpace stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                
                [_MessaggiMakes addObject:noWhiteSpace];
            }
            
            if ([elementName isEqualToString:@"description"]) {
                while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                    immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];
                
                [_MessaggiModels addObject:immutableString];
            }
            
            if ([elementName isEqualToString:@"link"]) {
                [_MessaggiImages addObject:immutableString];
            }
            
            if ([elementName isEqualToString:@"pubDate"])
            {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"dd MMM yyyy"];
                NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_EN"];
                [dateFormatter setLocale:locale];
                NSDate *dateFromString = [[NSDate alloc] init];
                // voila!
                NSString *value = [immutableString substringWithRange:NSMakeRange(5, 11)];
                dateFromString = [dateFormatter dateFromString:value];
                [_MessaggiDataPubblicazione addObject:dateFromString];
                
            }
            
        }
        
    }
    */
    if([elementName isEqualToString:@"category"])
    {
        
        if([caricaDatiAggiorna isEqualToString:@"1"])
        {
            caricaDatiAggiorna = @"1";
        }
        else
        {
            caricaDatiAggiorna = @"2";

        }
        
    }
    
    if([caricaDatiAggiorna isEqualToString:@"1"])
    {
        if ([elementName isEqualToString:@"title"]) {
            while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];
            NSString* noWhiteSpace =  [immutableString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            noWhiteSpace =[ noWhiteSpace stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            
            [_Messaggititle addObject:noWhiteSpace];
        }
        
        
        
        if ([elementName isEqualToString:@"link"]) {
            [_Messaggilink addObject:immutableString];
        }
        
        if ([elementName isEqualToString:@"company"]) {
           while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];
            NSString* noWhiteSpace =  [immutableString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            noWhiteSpace =[ noWhiteSpace stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
           [_Messaggicompany addObject:noWhiteSpace];
        }
        
        if ([elementName isEqualToString:@"job_title"]) {
            [_Messaggijob_title addObject:immutableString];
        }
        
        
        if ([elementName isEqualToString:@"location"]) {
            [_Messaggilocation addObject:immutableString];
            locationVar = @"1";
        }
        
        if ([elementName isEqualToString:@"loc_description"]) {
            [_Messaggiloc_description addObject:immutableString];
        }
        if ([elementName isEqualToString:@"loc_address"]) {
            [_Messaggiloc_address addObject:immutableString];
        }
        if ([elementName isEqualToString:@"summary"]) {
            [_Messaggisummary addObject:immutableString];
        }
        
        if ([elementName isEqualToString:@"posting_date"]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *dateFromString = [[NSDate alloc] init];
            // voila!
            NSString *value = [immutableString substringWithRange:NSMakeRange(0, 10)];
            dateFromString = [dateFormatter dateFromString:value];
            [_Messaggiposting_date addObject:dateFromString];
        }
        if ([elementName isEqualToString:@"closing_date"]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *dateFromString = [[NSDate alloc] init];
            // voila!
            NSString *value = [immutableString substringWithRange:NSMakeRange(0, 10)];
            dateFromString = [dateFormatter dateFromString:value];
            [_Messaggiclosing_date addObject:dateFromString];
        }
        
        if ([elementName isEqualToString:@"job_code"]) {
            [_Messaggijob_code addObject:immutableString];
        }
        if ([elementName isEqualToString:@"category"]) {
            [_Messaggicategory addObject:immutableString];
        }
        
        if ([elementName isEqualToString:@"department"]) {
            [_Messaggidepartment addObject:immutableString];
        }
        if ([elementName isEqualToString:@"shift"]) {
            [_Messaggishift addObject:immutableString];
        }
        
        if ([elementName isEqualToString:@"education"]) {
            [_Messaggieducation addObject:immutableString];
        }
        
        if ([elementName isEqualToString:@"pay_rate"]) {
            [_Messaggipay_rate addObject:immutableString];
        }
        
        if ([elementName isEqualToString:@"pay_range"]) {
            [_Messaggipay_range addObject:immutableString];
        }
        
        if ([elementName isEqualToString:@"duration"]) {
            [_Messaggiduration addObject:immutableString];
        }
        
        if ([elementName isEqualToString:@"travel"]) {
            [_Messaggitravel addObject:immutableString];
        }
        if ([elementName isEqualToString:@"job_description"]) {
  /*          while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];*/
            [_Messaggijob_description addObject:immutableString];
        }
        
        if ([elementName isEqualToString:@"preferred_skills"]) {
   /*         while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];*/
            [_Messaggipreferred_skills addObject:immutableString];
        }

        
    }
    
    if([caricaDatiAggiorna isEqualToString:@"2"])
    {
        caricaDatiAggiorna = @"1";
    }

    
    contenutoTag = [[NSMutableString alloc] init];
    
    storingCharacters = NO;
}




@end
