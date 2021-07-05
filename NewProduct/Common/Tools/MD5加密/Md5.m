//
//  Md5.m
//  NewProduct
//
//  Created by 狍子 on 2021/6/24.
//

#import "Md5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Md5


+ (NSString* )md5HexDigest:(NSString* )input {
    const char* str =[input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString* ret = [NSMutableString stringWithCapacity: CC_MD5_DIGEST_LENGTH];
    for(int i=0; i< CC_MD5_DIGEST_LENGTH; i++){
        [ret appendFormat:@"%02X", result];
    }
    return ret;
}

@end
