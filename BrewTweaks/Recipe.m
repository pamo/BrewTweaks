//
//  Recipe.m
//  BrewTweaks
//
//  Created by Pamela Ocampo on 5/3/13.
//  Copyright (c) 2013 Pamela Ocampo. All rights reserved.
//

#import "Recipe.h"


@implementation Recipe
-(id)initWithBrewMethod:(BrewMethod *)method roaster:(NSString *)roaster coffee:(NSString *)coffee{
    self = [super init];
    if(self){
        _method = method;
        _roaster = roaster;
        _coffee = coffee;
        _date = [NSDate date]; // today

        
        return self;
    }
    return nil;}
@end
