//
//  CSAdvocateService.m
//  Caresis
//
//  Created by James Kizer on 4/11/15.
//  Copyright (c) 2015 Caresis. All rights reserved.
//

#import "CSAdvocateService.h"
#import "CSPatientService.h"

@implementation CSAdvocateService


-(CSAdvocate *) currentAdvocate
{
    if (!_currentAdvocate) _currentAdvocate = [[CSAdvocate alloc]init];
    return _currentAdvocate;
}

+ (id)service  {
    static CSAdvocateService *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[self alloc] init];
    });
    return service;
}

-(void)getAdvocateOnSuccess:(void (^)(CSAdvocate *advocate))success
                    failure:(void (^)())failure
{
    
    [[CSPatientService service] getPatientOnSuccess:^(CSPatient *patient) {
        
        CSAdvocate *advocate = [[CSAdvocate alloc]init];
        advocate.advocateId = @(1);
        advocate.firstName = @"James";
        advocate.lastName = @"Kizer";
        advocate.address1 = @"606 3rd St";
        advocate.address2 = @"";
        advocate.city = @"Athens";
        advocate.state = @"PA";
        advocate.zip = @"18810";
        advocate.phone = @"6102486455";
        
        advocate.patient = patient;
        
        self.currentAdvocate = advocate;
         
         if (success)
             success(advocate);
        
    } failure:^{
        
        
    }];
}


@end
