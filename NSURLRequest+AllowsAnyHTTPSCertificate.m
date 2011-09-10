//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//

#if HTTP_ALLOWS_ANY_CERT
#import "NSURLRequest+AllowsAnyhttpsCertificate.h"

@implementation NSURLRequest (AllowsAnyHTTPSCertificate)

+ (BOOL) allowsAnyHTTPSCertificateForHost:(NSString*) host {
	return YES;
}

@end
#endif