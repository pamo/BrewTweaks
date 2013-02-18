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
@property (nonatomic, copy) NSString *grind;
@property (nonatomic) double ratio;
@property (nonatomic) double coffeeAmount;
@property (nonatomic) double waterAmount;
@property (nonatomic) double temp;
@property (nonatomic) int coffeeUnit;
@property (nonatomic) int waterUnit;
@property (nonatomic) int tempUnit;

-(id)initWithName:(NSString *)name grind:(NSString *)grind coffeeAmount:(double)coffeeAmount waterAmount:(double)waterAmount temp:(double)temp;
@end
