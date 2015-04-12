//
//  CSAppointmentService.m
//  Caresis
//
//  Created by James Kizer on 4/11/15.
//  Copyright (c) 2015 Caresis. All rights reserved.
//

#import "CSAppointmentService.h"
#import "CSAdvocateService.h"
#import "AFNetworking.h"
#import <AFNetworkActivityLogger.h>


@interface CSAppointmentService()

@property (strong, nonatomic) AFHTTPRequestOperationManager *operationManager;

@end

@implementation CSAppointmentService

+ (id)service {
    static CSAppointmentService *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[self alloc] init];
    });
    return service;
}

-(id)init{
    self = [super init];
    if (self) {
        
        NSString *baseURLString = @"http://52.10.137.12";
        
        self.operationManager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:baseURLString]];
        self.operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.operationManager.responseSerializer = [AFCompoundResponseSerializer compoundSerializerWithResponseSerializers:@[[AFJSONResponseSerializer serializer]]];
        
        [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];
        [[AFNetworkActivityLogger sharedLogger] startLogging];
        
//        self.operationManager.requestSerializer.HTTPShouldHandleCookies = YES;
        
//        self.imageOperationManger = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:baseURLString]];
//        self.imageOperationManger.responseSerializer = [AFImageResponseSerializer serializer];
//        self.operationManager.requestSerializer.HTTPShouldHandleCookies = YES;
        
//        self.retryCount = defaultRetryCount;
        
        //[self.operationManager.reachabilityManager startMonitoring];
        
        //since endpoints return mix of JSON and text, need compound serializer
        //note that this AFCompoundResponseSerializer tries AFJSONResponseSerializer
        //then AFHTTPResponseSerializer behavior.
        //self.operationManager.responseSerializer = [AFCompoundResponseSerializer compoundSerializerWithResponseSerializers:@[[AFJSONResponseSerializer serializer]]];
        
        
    }
    
    return self;
}


//for post
//title
//description
//date
//address

-(void)addAppointment:(CSAppointment *)appointment
{
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    dateFormat.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    "2014-02-07T03:10:59:434Z"
    NSString *address = @"test address";
//    NSDate* output = [dateFormat dateFromString:input];
    NSDictionary *params = @{
        @"title" : appointment.title,
        @"description" :appointment.appointmentDescription,
        @"date": [dateFormat stringFromDate:appointment.date],
        @"address": address
    };
    
    [self.operationManager POST:@"/api/apps/appointment/" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
}

-(void)getAppointmentsOnSuccess:(void (^)(NSArray *appointments))success
                        failure:(void (^)())failure
{
    
    [[CSAdvocateService service] getAdvocateOnSuccess:^(CSAdvocate *a) {
        
        
        [self.operationManager GET:@"/api/apps/appointment/" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if( [responseObject isKindOfClass:[NSArray class]])
            {
                NSDateFormatter *dateFormat = [NSDateFormatter new];
                dateFormat.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
                
                NSArray *appointmentArray = (NSArray *)responseObject;
                NSMutableArray *mutableAppointmentArray = [[NSMutableArray alloc] init];
                [appointmentArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                   
//                    "id": 4,
//                    "title": "blah",
//                    "address": "blah",
//                    "description": "blah",
//                    "date": "2015-08-08T12:33:00Z"
                    NSDictionary *appointmentDictionary = (NSDictionary *)obj;
                    CSAppointment *appointment = [[CSAppointment alloc]init];
                    appointment.advocate = a;
                    appointment.appointmentId = [appointmentDictionary[@"id"] integerValue];
                    appointment.title = appointmentDictionary[@"title"];
                    appointment.appointmentDescription = appointmentDictionary[@"description"];
                    appointment.date = [dateFormat dateFromString:appointmentDictionary[@"date"]];
                    appointment.address1 = @"111 8th Ave";
                    appointment.address2 = @"Suite 302";
                    appointment.city = @"NY";
                    appointment.zip = @"11201";
                    
                    [mutableAppointmentArray addObject:appointment];
                    
                }];
                
                if(success)
                    success([NSArray arrayWithArray:mutableAppointmentArray ]);
            }
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
            
        }];
        
//        CSAdvocate *advocate = a;
//        CSAppointment *appointment1 = [[CSAppointment alloc]init];
//        appointment1.appointmentId = @(1);
//        appointment1.advocate = advocate;
//        appointment1.title = @"Appointment 1 Title";
//        appointment1.appointmentDescription = @"Appointment 1 Description";
//        appointment1.address1 = @"606 3rd St";
//        appointment1.address2 = @"";
//        appointment1.city = @"Athens";
//        appointment1.state = @"PA";
//        appointment1.zip = @"18810";
//        appointment1.date = [NSDate date];
//        
//        CSAppointment *appointment2 = [[CSAppointment alloc]init];
//        appointment2.appointmentId = @(1);
//        appointment2.advocate = advocate;
//        appointment2.title = @"Appointment 2 Title";
//        appointment2.appointmentDescription = @"Appointment 2 Description";
//        appointment2.address1 = @"111 8th Ave";
//        appointment2.address2 = @"Suite 302";
//        appointment2.city = @"NY";
//        appointment2.zip = @"11201";
//        appointment2.date = [NSDate date];
//        
//        if(success)
//            success(@[appointment1, appointment2]);
//        
    } failure:^{
        
        
    }];
    
    
}



@end
