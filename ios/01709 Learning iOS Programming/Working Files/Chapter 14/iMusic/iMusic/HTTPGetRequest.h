//
//  HTTPGetRequest.h
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

typedef void(^SuccessBlock)(NSData *response);
typedef void(^FailureBlock)(NSError *error);

@interface HTTPGetRequest : NSObject

- (id)initWithURL:(NSURL *)requestURL successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
- (void)startRequest;

@end
