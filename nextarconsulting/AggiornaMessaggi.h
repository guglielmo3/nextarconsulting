//
//  AggiornaMessaggi.h
//  nextarconsulting
//
//  Created by Guglielmo Puglia on 03/05/14.
//  Copyright (c) 2014 Guglielmo Puglia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LavoriCompleta.h"


@interface AggiornaMessaggi : NSObject
{
    
    NSArray* _permissions;
    UIAlertView *objAlertView;
    IBOutlet UIButton *btnAggiorna;
    IBOutlet UIButton *btnAggiornaFoto;
    NSMutableString *contenutoTag;
    NSMutableArray *AnniMutableArray;
    NSMutableArray *AnniTotaleMutableArray;
    BOOL storingCharacters;
    
}
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

//@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UIButton  *btnAggiorna;
@property (nonatomic, retain) IBOutlet UIButton  *btnAggiornaFoto;
@property (nonatomic, retain) IBOutlet UIButton  *btnAggiornaDocumenti;
@property (nonatomic, retain) IBOutlet UIButton  *btnAggiornaVideo;

/*@property (strong, nonatomic) NSMutableArray *MessaggiListData;
@property (strong, nonatomic) NSMutableArray *FotoListData;
@property (strong, nonatomic) NSMutableArray *DocumentiListData;
@property (strong, nonatomic) NSMutableArray *VideoListData;
@property (nonatomic, strong) NSMutableArray *MessaggiImages;
@property (nonatomic, strong) NSMutableArray *MessaggiMakes;
@property (nonatomic, strong) NSMutableArray *MessaggiModels;
@property (nonatomic, strong) NSMutableArray *MessaggiDataPubblicazione;

@property (nonatomic, strong) NSMutableArray *MAFotoAnno;
@property (nonatomic, strong) NSMutableArray *MADocumentiAnno;
@property (nonatomic, strong) NSMutableArray *MAvideoAnno;*/

@property (nonatomic, strong) NSMutableArray *Messaggititle;
@property (nonatomic, strong) NSMutableArray *Messaggilink;
@property (nonatomic, strong) NSMutableArray *Messaggicompany;
@property (nonatomic, strong) NSMutableArray *Messaggijob_title;
@property (nonatomic, strong) NSMutableArray *Messaggilocation;
@property (nonatomic, strong) NSMutableArray *Messaggiloc_description;
@property (nonatomic, strong) NSMutableArray *Messaggiloc_address;
@property (nonatomic, strong) NSMutableArray *Messaggisummary;
@property (nonatomic, strong) NSMutableArray *Messaggiposting_date;
@property (nonatomic, strong) NSMutableArray *Messaggiclosing_date;
@property (nonatomic, strong) NSMutableArray *Messaggijob_code;
@property (nonatomic, strong) NSMutableArray *Messaggicategory;
@property (nonatomic, strong) NSMutableArray *Messaggidepartment;
@property (nonatomic, strong) NSMutableArray *Messaggishift;
@property (nonatomic, strong) NSMutableArray *Messaggieducation;
@property (nonatomic, strong) NSMutableArray *Messaggipay_rate;
@property (nonatomic, strong) NSMutableArray *Messaggipay_range;
@property (nonatomic, strong) NSMutableArray *Messaggiduration;
@property (nonatomic, strong) NSMutableArray *Messaggitravel;
@property (nonatomic, strong) NSMutableArray *Messaggijob_description;
@property (nonatomic, strong) NSMutableArray *Messaggipreferred_skills;



@property (strong, nonatomic) LavoriCompleta *currentMessaggi;

@property (nonatomic, retain) NSMutableArray *AnniMutableArray;



-(BOOL)AggiornaDati;


@end
