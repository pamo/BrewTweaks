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
    @property (nonatomic) NSDecimal *ratio;
    @property (nonatomic) NSDecimal *coffeeAmount;
    @property (nonatomic) NSDecimal *waterAmount;
    @property (nonatomic) NSDecimal *temp;
    @property (nonatomic) NSInteger *coffeeUnit;
    @property (nonatomic) NSInteger *waterUnit;
    @property (nonatomic) NSInteger *tempUnit;

    -(id)initWithName:(NSString *)name;
@end
