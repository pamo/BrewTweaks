//
//  BrewMethod.m
//  BrewTweaks
//
//  Created by Pamela Ocampo on 2/17/13.
//  Copyright (c) 2013 Pamela Ocampo. All rights reserved.
//

#import "BrewMethod.h"

@implementation BrewMethod
-(id)initWithName:(NSString *)name grind:(NSString *)grind coffeeAmount:(double)coffeeAmount waterAmount:(double)waterAmount temp:(double)temp{
    self = [super init];
    if(self){
        _name = name;
        _grind = grind;
        _coffeeAmount = coffeeAmount;
        _waterAmount = waterAmount;
        _temp = temp;
        return self;
    }
    return nil;
    
}
@end
