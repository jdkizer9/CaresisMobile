//
//  CSAppointmentService.h
//  Caresis
//
//  Created by James Kizer on 4/11/15.
//  Copyright (c) 2015 Caresis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSAppointment.h"

@interface CSAppointmentService : NSObject

+ (id)service;

-(void)addAppointment:(CSAppointment *)appointment;

-(void)getAppointmentsOnSuccess:(void (^)(NSArray *appointments))success
                        failure:(void (^)())failure;

@end
