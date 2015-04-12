//
//  CSAppointment.h
//  Caresis
//
//  Created by James Kizer on 4/11/15.
//  Copyright (c) 2015 Caresis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSAdvocate.h"

@interface CSAppointment : NSObject

@property (nonatomic) NSInteger appointmentId;
@property (strong, nonatomic) CSAdvocate *advocate;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *appointmentDescription;
@property (strong, nonatomic) NSString *address1;
@property (strong, nonatomic) NSString *address2;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *zip;
@property (strong, nonatomic) NSDate *date;

//for post
//title
//description
//date
//address

@end
