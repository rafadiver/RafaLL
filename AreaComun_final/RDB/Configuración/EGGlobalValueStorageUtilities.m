//
//  EGGlobalValueStorageUtilities.m
//  RDB
//
//  Created by Hugo M Morales Hdez on 18/03/18.
//  Copyright © 2018 AutoChilango. All rights reserved.
//

#import "EGGlobalValueStorageUtilities.h"

@implementation EGGlobalValueStorageUtilities

+(id)sharedManager {
    
    static EGGlobalValueStorageUtilities *sharedManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        
    });
    
    return sharedManager;

}

-(void) setFirstUser:(BOOL)flag {
    
    [self saveValue:flag forKey:@"eg_first_user"];
    
}

-(BOOL) getFirstUser {
    
    return [self loadValue:@"eg_first_user"];
    
}

// General Methods
-(void)saveValue:(BOOL)value forKey:(NSString *)key {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:key];
    [defaults synchronize];
    
}

-(BOOL)loadValue:(NSString *)value {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:value];
    
}

@end
