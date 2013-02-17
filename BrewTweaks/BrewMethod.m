//
//  BrewMethod.m
//  BrewTweaks
//
//  Created by Pamela Ocampo on 2/17/13.
//  Copyright (c) 2013 Pamela Ocampo. All rights reserved.
//

#import "BrewMethod.h"

@implementation BrewMethod
-(id)initWithName:(NSString *)name{
    self = [super init];
    if(self){
        _name = name;
        return self;
    }
    return nil;
    
}
@end
