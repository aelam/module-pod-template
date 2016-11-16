//
//  EMAppSettings.m
//  EMStock
//
//  Created by ryan on 15/11/5.
//  Copyright © 2015年 flora. All rights reserved.
//

#import "EMAppSettings.h"
#import "EMSocialEMStockConfigurator.h"

#define kPlatformID         9           // iphone平台号
#define kProductID          15          // 产品号
#define kAppID              (939983858) // itunes connect 应用ID
#define kAppStoreVendorID   100

NSString *DefaultVendorConfig();

@interface EMAppSettings (){
    NSInteger _vendorID;
}

@end

@implementation EMAppSettings


- (instancetype)init {
    if (self = [super init]) {
        //从本地读取缓存vendor Id
        NSString *vendorID = [[NSUserDefaults standardUserDefaults] objectForKey:@"em_vendorId"];

        if (vendorID && vendorID.length) {
            _vendorID = [vendorID integerValue];
        } else {//读取本地配置ID
            _vendorID = [[self defaultVendorConfig] integerValue];
        }
    }
    return self;
}

- (NSInteger)appID {
    return kAppID;
}

- (NSInteger)productID {
    return kProductID;
}

- (NSInteger)platformID {
    return kPlatformID;
}

- (void)setVendorID:(NSInteger)vendorID {
    _vendorID = vendorID;
}

- (NSString *)defaultVendorConfig {
    static NSString *text = nil;
    if (!text) {
        text = @"100";

        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"txt"];
        if (filePath && [filePath length] > 0) {
            text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        }
    }

    return text;
}

- (NSString *)mainURLScheme {
    return @"emstock";
}

- (NSArray *)supportsURLSchemes {
    return @[@"emstock", @"emlite"];
}

+ (BOOL)isAppStoreVersion {
    return [[self appSettings] vendorID] == kAppStoreVendorID;
}

#if __MODULE_SHARE_ENABLED__
- (EMSocialDefaultConfigurator *)shareConfigurator {
    return [EMSocialEMStockConfigurator new];
}

#endif

#if __MODULE_PAY_ENABLED__
- (EMPayDefaultConfiurator *)payDefaultConfiurator {
    return [EMAppPayConfiurator new];
}

#endif

#if __MODULE_INFO_ENABLED__
- (BOOL)isVIPInfoExpiredShowed {
    return [EMUserCustomData sharedData].guid.isVIPInfoExpiredShowed;
}

#endif

- (void)save {
    [[NSUserDefaults standardUserDefaults] setObject:@(self.vendorID).stringValue forKey:@"em_vendorId"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

@end



