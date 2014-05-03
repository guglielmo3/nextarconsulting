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
#import "Lavori.h"


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

@property (strong, nonatomic) NSMutableArray *MessaggiListData;
@property (strong, nonatomic) NSMutableArray *FotoListData;
@property (strong, nonatomic) NSMutableArray *DocumentiListData;
@property (strong, nonatomic) NSMutableArray *VideoListData;
@property (nonatomic, strong) NSMutableArray *MessaggiImages;
@property (nonatomic, strong) NSMutableArray *MessaggiMakes;
@property (nonatomic, strong) NSMutableArray *MessaggiModels;
@property (nonatomic, strong) NSMutableArray *MessaggiDataPubblicazione;

@property (nonatomic, strong) NSMutableArray *MAFotoAnno;
@property (nonatomic, strong) NSMutableArray *MADocumentiAnno;
@property (nonatomic, strong) NSMutableArray *MAvideoAnno;

@property (strong, nonatomic) Lavori *currentMessaggi;

@property (nonatomic, retain) NSMutableArray *AnniMutableArray;



-(BOOL)AggiornaDati;


@end
