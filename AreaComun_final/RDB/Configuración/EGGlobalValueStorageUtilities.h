//
//  EGGlobalValueStorageUtilities.h
//  RDB
//
//  Created by Hugo M Morales Hdez on 18/03/18.
//  Copyright © 2018 AutoChilango. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EGGlobalValueStorageUtilities : NSObject


+(id)sharedManager;

-(void) setFirstUser:(BOOL)flag;
-(BOOL) getFirstUser;


@end
