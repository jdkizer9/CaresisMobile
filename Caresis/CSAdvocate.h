//
//  CSAdvocate.h
//  Caresis
//
//  Created by James Kizer on 4/11/15.
//  Copyright (c) 2015 Caresis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSPatient.h"

@interface CSAdvocate : NSObject

@property (strong, nonatomic) NSValue *advocateId;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *address1;
@property (strong, nonatomic) NSString *address2;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *zip;
@property (strong, nonatomic) NSString *phone;

@property (weak, nonatomic) CSPatient *patient;



@end
