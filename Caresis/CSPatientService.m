//
//  CSPatientService.m
//  Caresis
//
//  Created by James Kizer on 4/11/15.
//  Copyright (c) 2015 Caresis. All rights reserved.
//

#import "CSPatientService.h"

@implementation CSPatientService


-(CSPatient *) currentPatient
{
    if (!_currentPatient) _currentPatient = [[CSPatient alloc]init];
    return _currentPatient;
}

+ (id)service {
    static CSPatientService *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[self alloc] init];
    });
    return service;
}

-(void)getPatientOnSuccess:(void (^)(CSPatient *patient))success
                   failure:(void (^)())failure
{
    CSPatient *patient = [[CSPatient alloc]init];
    patient.patientId = @(1);
    patient.firstName = @"Bob";
    patient.lastName = @"Stevens";
    patient.address1 = @"606 3rd St";
    patient.address2 = @"";
    patient.city = @"Athens";
    patient.state = @"PA";
    patient.zip = @"18810";
    patient.phone = @"6102486455";
    
    self.currentPatient = patient;
    
    if(success)
        success(patient);
    
}

@end
