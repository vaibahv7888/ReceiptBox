/*
 SoapRequest.m
 Implementation of the request object used to manage asynchronous requests.
 Author:	Jason Kichline, andCulture - Harrisburg, Pennsylvania USA
*/

#import "SoapRequest.h"
#import "SoapArray.h"
#import "SoapFault.h"
#import "Soap.h"
#import "SDZUploadImageParse.h"
#import "SDZUploadImage.h"
#import "AppDelegate.h"

@implementation SoapRequest

@synthesize handler, url, soapAction, postData, receivedData, username, password, deserializeTo, action, logging, defaultHandler;

// Creates a request to submit from discrete values.
+ (SoapRequest*) create: (SoapHandler*) handler urlString: (NSString*) urlString soapAction: (NSString*) soapAction postData: (NSString*) postData deserializeTo: (id) deserializeTo {
	return [SoapRequest create: handler action: nil urlString: urlString soapAction: soapAction postData: postData deserializeTo: deserializeTo];
}

+ (SoapRequest*) create: (SoapHandler*) handler action: (SEL) action urlString: (NSString*) urlString soapAction: (NSString*) soapAction postData: (NSString*) postData deserializeTo: (id) deserializeTo {
	SoapRequest* request = [[SoapRequest alloc] init];
	request.url = [NSURL URLWithString: urlString];
	request.soapAction = soapAction;
	request.postData = [postData retain];
	request.handler = handler;
	request.deserializeTo = deserializeTo;
	request.action = action;
	request.defaultHandler = nil;
	return [request autorelease];
}

+ (SoapRequest*) create: (SoapHandler*) handler action: (SEL) action service: (SoapService*) service soapAction: (NSString*) soapAction postData: (NSString*) postData deserializeTo: (id) deserializeTo {
 	SoapRequest* request = [SoapRequest create: handler action: action urlString: service.serviceUrl soapAction: soapAction postData:postData deserializeTo:deserializeTo];
	request.defaultHandler = service.defaultHandler;
	request.logging = service.logging;
	request.username = service.username;
	request.password = service.password;
	return request;
}

//+ (SoapRequest*) createForReceipt: (SoapHandler*) handler action: (SEL) action service: (SoapService*) service soapAction: (NSString*) soapAction postData: (NSString*) postData deserializeTo: (id) deserializeTo {
//    AppDelegate * mAppDelegate = (TAppDelegate *)[[UIApplication sharedApplication] delegate];
//    SoapRequest* request = [SoapRequest create: handler action: action urlString:[mAppDelegate.userAppSettings valueForKey:@"OCRServiceURL"]  soapAction: soapAction postData:postData deserializeTo:deserializeTo];
//    request.defaultHandler = service.defaultHandler;
//    request.logging = service.logging;
//    request.username = service.username;
//    request.password = service.password;
//    request.deserializeTo=deserializeTo;
//    return request;
//}
// Sends the request via HTTP.
- (void) send {
	
	// If we don't have a handler, create a default one
	if(handler == nil) {
		handler = [[SoapHandler alloc] init];
	}
	
	// Make sure the network is available
	if([SoapReachability connectedToNetwork] == NO) {
		NSError* error = [NSError errorWithDomain:@"SudzC" code:400 userInfo:[NSDictionary dictionaryWithObject:@"The network is not available" forKey:NSLocalizedDescriptionKey]];
		[self handleError: error];
	}
	
	// Make sure we can reach the host
	if([SoapReachability hostAvailable:url.host] == NO) {
		NSError* error = [NSError errorWithDomain:@"SudzC" code:410 userInfo:[NSDictionary dictionaryWithObject:@"The host is not available" forKey:NSLocalizedDescriptionKey]];
		[self handleError: error];
	}
	
	// Output the URL if logging is enabled
	if(logging) {
		NSLog(@"Loading: %@", url.absoluteString);
	}
	
	// Create the request
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: url];
	if(soapAction != nil) {
		[request addValue: soapAction forHTTPHeaderField: @"SOAPAction"];
	}
	if(postData != nil) {
		[request setHTTPMethod: @"POST"];
		
		if ( ![soapAction caseInsensitiveCompare:@"http://www.gorillaexpense.net/mobile/Service_Mobile/UploadFileBuffered"] ) 
		{
			[request addValue: @"application/xop+xml" forHTTPHeaderField: @"Content-Type"];			
		}
		else 
		{
			[request addValue: @"text/xml" forHTTPHeaderField: @"Content-Type"];
		}

		[request setHTTPBody: [postData dataUsingEncoding: NSUTF8StringEncoding]];
		if(self.logging) {
			//NSLog(@"%@", postData);
		}
	}
    [request setHTTPShouldHandleCookies:NO];

	// Create the connection
	conn = [[NSURLConnection alloc] initWithRequest: request delegate: self];
	if(conn) {
		receivedData = [[NSMutableData data] retain];
	} else {
		// We will want to call the onerror method selector here...
		if(self.handler != nil) {
			NSError* error = [NSError errorWithDomain:@"SoapRequest" code:404 userInfo: [NSDictionary dictionaryWithObjectsAndKeys: @"Could not create connection", NSLocalizedDescriptionKey,nil]];
			[self handleError: error];
		}
	}
}

-(void)handleError:(NSError*)error{
    SEL onerror = @selector(onerror:);
    if(self.action != nil) { onerror = self.action; }
    if([self.handler respondsToSelector: onerror]) {
        if ([self.deserializeTo isKindOfClass:[SDZUploadImageParse class]]) {
            [self.handler performSelector: onerror withObject:self.deserializeTo];
            
        }
        else{
            [self.handler performSelector: onerror withObject: error];
        }
    } else {
        if(self.defaultHandler != nil && [self.defaultHandler respondsToSelector:onerror]) {
            if ([self.deserializeTo isKindOfClass:[SDZUploadImageParse class]]) {
                [self.defaultHandler performSelector: onerror withObject: self.deserializeTo];
                
            }
            else{
                [self.defaultHandler performSelector:onerror withObject: error];
            }
        }
    }
    if(self.logging) {
        NSLog(@"Error: %@", error.localizedDescription);
    }
}
//-(void)handleError:(NSError*)error{
//	SEL onerror = @selector(onerror:);
//	if(self.action != nil) { onerror = self.action; }
//	if([self.handler respondsToSelector: onerror]) {
//		[self.handler performSelector: onerror withObject: error];
//	} else {
//		if(self.defaultHandler != nil && [self.defaultHandler respondsToSelector:onerror]) {
//			[self.defaultHandler performSelector:onerror withObject: error];
//		}
//	}
//	if(self.logging) {
//		NSLog(@"Error: %@", error.localizedDescription);
//	}
//}

-(void)handleFault:(SoapFault*)fault{
	if([self.handler respondsToSelector:@selector(onfault:)]) {
		[self.handler onfault: fault];
	} else if(self.defaultHandler != nil && [self.defaultHandler respondsToSelector:@selector(onfault:)]) {
		[self.defaultHandler onfault:fault];
	}
	if(self.logging) {
		NSLog(@"Fault: %@", fault);
	}
}

// Called when the HTTP socket gets a response.
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.receivedData setLength:0];
}

// Called when the HTTP socket received data.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)value {
    [self.receivedData appendData:value];
}

// Called when the HTTP request fails.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[conn release];
	conn = nil;
	[self.receivedData release];
	[self handleError:error];
}

// Called when the connection has finished loading.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void){

	NSString* response;
	if(self.logging == YES) {
		response = [[[NSString alloc] initWithData: self.receivedData encoding: NSUTF8StringEncoding] autorelease];
	}
	
	// initialize scanner for scanning the string to remove unwanted data.
	NSScanner *responseScanner = [[NSScanner alloc] initWithString:response];
	
	if ( [responseScanner scanUpToString:@"<s:Envelope" intoString:&response] == YES ) 
	{
		[responseScanner scanUpToString:@"s:Envelope>" intoString:&response];
		response = [response stringByAppendingString:@"s:Envelope>"];
        NSLog(@"response= %@",response);
//        NSLog(@"Success");
	}
	else 
	{
		response=@"";
	}

	
	[responseScanner release];
	
	// convert the string to parse into NSData
	[self.receivedData setData:[response dataUsingEncoding:NSUTF8StringEncoding]];
	
//    dispatch_async(dispatch_get_main_queue(), ^(void){
        NSError* error;

	CXMLDocument* doc = [[CXMLDocument alloc] initWithData: self.receivedData options: 0 error: &error];
	if(doc == nil) {
		[self handleError:error];
		return;
	}

	id output = nil;
    id output1 = nil;
    id dictOutput = nil;
    NSMutableArray *receiptList = nil;
	SoapFault* fault = [SoapFault faultWithXMLDocument: doc];

	if([fault hasFault]) {
		if(self.action == nil) {
			[self handleFault: fault];
		} else {
			if(self.handler != nil && [self.handler respondsToSelector: self.action]) {
                if ([deserializeTo isKindOfClass:[SDZUploadImageParse class]] ||  [deserializeTo isKindOfClass:[SDZUploadImage class]]) {
                    output=[deserializeTo initWithFault:fault];
                }
				[self.handler performSelector: self.action withObject: fault];
			} else {
				NSLog(@"SOAP Fault: %@", fault);
			}
		}
	} else {
		CXMLNode* element = [[Soap getNode: [doc rootElement] withName: @"Body"] childAtIndex:0];
//        NSLog(@"element= %@", element);
		if(deserializeTo == nil) {
			output = [Soap deserialize:element];
		} else {
			if([deserializeTo respondsToSelector: @selector(initWithNode:)]) {
                if ([deserializeTo isKindOfClass:[SDZUploadImageParse class]]) {
                    output = [deserializeTo initWithNode: element];
                    dictOutput=output;
                }
                else
                {
                    element = [element childAtIndex:0];
                    output = [deserializeTo initWithNode: element];
                    dictOutput=output;
                }
			} else {
                NSInteger count = [[Soap getNode: element withName: @"GetPendingListResult"] childCount];
                if(count > 0) {
                    receiptList = [[NSMutableArray alloc] init];
//                    CXMLNode *temp = [Soap getNode: element withName: @"GetPendingListResult"];
//                    NSMutableArray *receiptList = [[temp children] mutableCopy];
                    CXMLNode *pendingListResult = [Soap getNode: element withName: @"vw_Receiptbox"];
                    int count2 = (int)[pendingListResult childCount];
                    for (int i=0; i<count; i++) {
                        NSMutableDictionary *receiptItem = [[NSMutableDictionary alloc] init];
                        for (int j=0; j<count2; j++) {
                            CXMLNode* vm_receiptBox = [[Soap getNode: element withName: @"GetPendingListResult"] childAtIndex:i];
                            NSString *name = [[vm_receiptBox childAtIndex:j] name];
                            NSString *value = [[vm_receiptBox childAtIndex:j] stringValue];
                            if(value == nil) {
                                [receiptItem setObject:[NSString stringWithFormat:@""] forKey:name];
                            } else {
                                [receiptItem setObject:value forKey:name];
                            }
                        }
                        [receiptList addObject:receiptItem];
                    }
                    
//                    CXMLNode* e1 = [[Soap getNode: element withName: @"GetPendingListResult"] childAtIndex:0];
//                    NSLog(@"element name at index0= %@", [[e1 childAtIndex:7] name]);
//                    NSLog(@"element value at index0= %@", [[e1 childAtIndex:7] stringValue]);
//                    NSLog(@"element count = %ld", (long)count);
                } else {
                    NSInteger count2 = [[Soap getNode: element withName: @"UploadedReceiptInfo"] childCount];
                    if (count2 > 0) {
                        receiptList = [[NSMutableArray alloc] init];
                        CXMLNode *uploadReceiptInfo = [Soap getNode: element withName: @"UploadedReceiptInfo"];
                        NSMutableDictionary *receiptItem = [[NSMutableDictionary alloc] init];
                        
                        int fieldsCount = (int)[uploadReceiptInfo childCount];
                        
                        for (int i=0; i<fieldsCount; i++) {
                            NSString *name = [[uploadReceiptInfo childAtIndex:i] name];
                            NSString *value = [[uploadReceiptInfo childAtIndex:i] stringValue];
                            if(value == nil) {
                                [receiptItem setObject:[NSString stringWithFormat:@""] forKey:name];
                            } else {
                                [receiptItem setObject:value forKey:name];
                            }
                        }
                        [receiptList addObject:receiptItem];
                    } else {
                        NSString* value = [[[element childAtIndex:0] childAtIndex:0] stringValue];
                        output = [Soap convert: value toType: deserializeTo];
                        CXMLNode* element2 =[Soap getNode: element withName: @"UniqueFileId"];
                        NSString* value2 = (element2)?[[element2 childAtIndex:0]stringValue]:nil;
                        if (value2!=nil) {
                            output1 = [Soap convert: value2 toType: deserializeTo];
                            CXMLNode* element3 =[Soap getNode: element withName: @"UploadSucceeded"];
                            NSString* value3 = (element2)?[[element3 childAtIndex:0]stringValue]:nil;
                            dictOutput=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:value,value2,value3, nil] forKeys:[NSArray arrayWithObjects:@"imagePath",@"imageID",@"Status", nil]];
                        }
                        else
                        {
                            dictOutput=output;
                        }
                    }
                }
			}
		}
		
		if(self.action == nil) { self.action = @selector(onload:); }
		if(self.handler != nil && [self.handler respondsToSelector: self.action]) {
            if (dictOutput != nil) {
                [self.handler performSelector: self.action withObject: dictOutput];
            } else {
                [self.handler performSelector: self.action withObject: receiptList];
            }
		} else if(self.defaultHandler != nil && [self.defaultHandler respondsToSelector:@selector(onload:)]) {
			[self.defaultHandler onload:dictOutput];
		}
	}
	[self.handler release];
	[doc release];
	[conn release];	
	conn = nil;
	[self.receivedData release];
//    });
//    });
}

// Called if the HTTP request receives an authentication challenge.
-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	if([challenge previousFailureCount] == 0) {
		NSURLCredential *newCredential;
        newCredential=[NSURLCredential credentialWithUser:self.username password:self.password persistence:NSURLCredentialPersistenceNone];
        [[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
		NSError* error = [NSError errorWithDomain:@"SoapRequest" code:403 userInfo: [NSDictionary dictionaryWithObjectsAndKeys: @"Could not authenticate this request", NSLocalizedDescriptionKey,nil]];
		[self handleError:error];
    }
}

// Cancels the HTTP request.
- (BOOL) cancel {
	if(conn == nil) { return NO; }
	[conn cancel];
	[conn release];
	conn = nil;
	return YES;
}

// Deallocates the object
- (void) dealloc {
    if (defaultHandler) {
        [defaultHandler release];
    }
	[url release];
	[soapAction release];
	[username release];
	[password release];
	[deserializeTo release];
	[postData release];
	[super dealloc];
}

@end
