//
//  HTTPGetRequest.m
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "HTTPGetRequest.h"

@interface HTTPGetRequest ()
@property (nonatomic, strong) SuccessBlock successBlock;
@property (nonatomic, strong) FailureBlock failureBlock;
@property (nonatomic, strong) NSURL *requestURL;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation HTTPGetRequest

@synthesize connection = _connection;
@synthesize responseData = _responseData;
@synthesize requestURL = _requestURL;
@synthesize successBlock = _successBlock;
@synthesize failureBlock = _failureBlock;

- (id)initWithURL:(NSURL *)requestURL successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
	self = [super init];
	if (self) {
		self.requestURL = requestURL;
		self.successBlock = successBlock;
		self.failureBlock = failureBlock;
	}
	return self;
}

- (void)startRequest {
	NSURLRequest *request = [NSURLRequest requestWithURL:self.requestURL];
	self.responseData = [[NSMutableData alloc] init];
	self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)theConnection didReceiveResponse:(NSURLResponse *)response {
	[self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data {
	[self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error {
    self.responseData = nil;
    self.connection = nil;
	self.failureBlock(error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection {
	self.successBlock([NSData dataWithData:self.responseData]);
}

@end
