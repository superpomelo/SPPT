//
//  Md5.h
//  NewProduct
//
//  Created by 狍子 on 2021/6/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Md5 : NSObject
//md5加密方法
+ (NSString* )md5HexDigest:(NSString* )input;
@end

NS_ASSUME_NONNULL_END

