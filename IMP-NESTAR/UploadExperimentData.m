//
//  UploadExperimentData.m
//  IMP-NESTAR
//
//  Created by Julian Vogels on 3/6/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import "UploadExperimentData.h"

@implementation UploadExperimentData

@synthesize delegate;
@synthesize uploadData;
@synthesize uploadURL;

-(instancetype)initWithData:(NSMutableDictionary *)data andURL:(NSURL *)url {
    uploadURL = url;
    uploadData = data;
    
    return self;
}

-(void) upload {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:[uploadURL absoluteString] parameters:uploadData success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
        [delegate hasUploadedData:self withStatus:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
        [delegate hasUploadedData:self withStatus:NO];
    }];
    
//    [manager POST:[uploadURL absoluteString] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        if(uploadData){
//            [formData appendPartWithHeaders:<#(NSDictionary *)#> body:<#(NSData *)#>]
//            [formData appendPartWithFileData:UIImageJPEGRepresentation(_profileImageView.image, 0.5) name:@"avatar" fileName:@"avatar.jpg" mimeType:@"image/jpeg"];
//        }
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [delegate hasUploadedData:self withStatus:YES];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [delegate hasUploadedData:self withStatus:NO];
//    }];
    
}

@end
