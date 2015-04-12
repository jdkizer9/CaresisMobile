//
//  CSPatientService.h
//  Caresis
//
//  Created by James Kizer on 4/11/15.
//  Copyright (c) 2015 Caresis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSPatient.h"

@interface CSPatientService : NSObject


+ (id)service;

-(void)getPatientOnSuccess:(void (^)(CSPatient *patient))success
                    failure:(void (^)())failure;

@property (strong, nonatomic) CSPatient *currentPatient;


@end
