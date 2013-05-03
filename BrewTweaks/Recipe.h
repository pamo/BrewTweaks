//
//  Recipe.h
//  BrewTweaks
//
//  Created by Pamela Ocampo on 5/3/13.
//  Copyright (c) 2013 Pamela Ocampo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BrewMethod.h"

@interface Recipe : NSObject
@property (nonatomic, copy) NSString *roaster;
@property (nonatomic, copy) NSString *coffee;
@property (nonatomic, copy) BrewMethod *method;
@property (nonatomic, strong) NSDate *date;

-(id)initWithBrewMethod:(BrewMethod *)method roaster:(NSString *)roaster coffee:(NSString *)coffee;


@end
