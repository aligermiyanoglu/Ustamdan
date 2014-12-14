//
//  SHUserManager.m
//  SmartHome
//
//  Created by Ali Germiyanoglu on 24/11/14.
//
//

#import "USUserManager.h"

NSString* const SHUserStorageKey									= @"storedUserKey";

static USUserManager *manager;

@implementation USUserManager

+ (USUserManager *)getInstance {
    if (!manager) {
        manager = [[USUserManager alloc] init];
    }
    return manager;
}

#pragma mark - KeyedArchiver Methods

- (void)saveCustomObject:(NSDictionary *)object {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:SHUserStorageKey];
    [defaults synchronize];
    
}

- (void)deleteCustomObjectFromUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:SHUserStorageKey];
    [defaults synchronize];
    
}

- (NSDictionary *)loadCustomObject{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:SHUserStorageKey];
    NSDictionary *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}



@end
