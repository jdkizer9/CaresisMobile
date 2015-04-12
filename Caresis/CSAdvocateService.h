//
//  CSAdvocateService.h
//  Caresis
//
//  Created by James Kizer on 4/11/15.
//  Copyright (c) 2015 Caresis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSAdvocate.h"

@interface CSAdvocateService : NSObject


+ (id)service;

-(void)getAdvocateOnSuccess:(void (^)(CSAdvocate *advocate))success
                        failure:(void (^)())failure;

@property (strong, nonatomic) CSAdvocate *currentAdvocate;


@end
