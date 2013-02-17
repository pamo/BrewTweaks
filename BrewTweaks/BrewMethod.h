//
//  BrewMethod.h
//  BrewTweaks
//
//  Created by Pamela Ocampo on 2/17/13.
//  Copyright (c) 2013 Pamela Ocampo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrewMethod : NSObject
    @property (nonatomic, copy) NSString *name;
    -(id)initWithName:(NSString *)name;
@end
