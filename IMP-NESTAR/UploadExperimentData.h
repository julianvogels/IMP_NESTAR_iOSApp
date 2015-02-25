//
//  UploadExperimentData.h
//  IMP-NESTAR
//
//  Created by Julian Vogels on 3/6/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@class UploadExperimentData;
@protocol UploadExperimentDataDelegate <NSObject>
@optional

-(void) hasUploadedData:(UploadExperimentData *)sender withStatus:(BOOL)success;

@end

@interface UploadExperimentData : NSObject

@property (strong, nonatomic) NSMutableDictionary *uploadData;
@property (strong, nonatomic) NSURL *uploadURL;
@property (strong, nonatomic) id <UploadExperimentDataDelegate> delegate;

-(void)upload;
-(instancetype)initWithData:(NSMutableDictionary *)data andURL:(NSURL *)url;


@end
