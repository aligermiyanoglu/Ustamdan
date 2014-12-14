//
//  SHUserManager.h
//  SmartHome
//
//  Created by Ali Germiyanoglu on 24/11/14.
//
//

#import <Foundation/Foundation.h>


extern NSString* const SHUserStorageKey;


@interface USUserManager : NSObject

+ (USUserManager *)getInstance;

- (void)saveCustomObject:(NSDictionary *)object;

- (void)deleteCustomObjectFromUserDefaults;

- (NSDictionary *)loadCustomObject;

@end
