//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//

#if HTTP_ALLOWS_ANY_CERT
#import <Foundation/Foundation.h>


@interface NSURLRequest (AllowsAnyHTTPSCertificate)

+ (BOOL) allowsAnyHTTPSCertificateForHost:(NSString*) host;

@end
#endif