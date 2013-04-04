//
//  BrewMethodDataController.m
//  BrewTweaks
//
//  Created by Pamela Ocampo on 2/17/13.
//  Copyright (c) 2013 Pamela Ocampo. All rights reserved.
//

#import "BrewMethodDataController.h"
#import "BrewMethod.h"

@interface BrewMethodDataController()
    - (void)initializeDefaultDataList;
@end

@implementation BrewMethodDataController
-(void)initializeDefaultDataList{
    NSMutableArray *methodList = [[NSMutableArray alloc] init];
    NSMutableArray *grindTypes = [[NSMutableArray alloc] init];
    grindTypes[0] = @"Coarse";
    grindTypes[1] = @"Medium-Coarse";
    grindTypes[2] = @"Medium";
    grindTypes[3] = @"Medium-Fine";
    grindTypes[4] = @"Fine";
    
    self.masterBrewMethodList = methodList;
    BrewMethod *method;
    
    method = [[BrewMethod alloc] initWithName:@"French Press" grind:grindTypes[0] coffeeAmount:25.0 waterAmount:400.0 temp:195.0];

    [self addBrewMethodWithBrewMethod:method];
    
    method = [[BrewMethod alloc] initWithName:@"Chemex" grind:grindTypes[1] coffeeAmount:44.0 waterAmount:700.0 temp:200.0];
    
    [self addBrewMethodWithBrewMethod:method];
    
    
    method = [[BrewMethod alloc] initWithName:@"Hario V60 Dripper" grind:grindTypes[4] coffeeAmount:25.0 waterAmount:400.0 temp:210.0];
    
    [self addBrewMethodWithBrewMethod:method];
    
    method = [[BrewMethod alloc] initWithName:@"AeroPress" grind:grindTypes[2] coffeeAmount:17.0 waterAmount:100.0 temp:175.0];
    
    [self addBrewMethodWithBrewMethod:method];
    method = [[BrewMethod alloc] initWithName:@"Melitta" grind:grindTypes[3] coffeeAmount:23.0 waterAmount:336.0 temp:205.0];
    
    [self addBrewMethodWithBrewMethod:method];
    
}
- (void)setMasterBrewMethodList:(NSMutableArray *)newList {
    if (_masterBrewMethodList != newList) {
        _masterBrewMethodList = [newList mutableCopy];
    }
}
- (id)init {
    if (self = [super init]) {
        [self initializeDefaultDataList];
        return self;
    }
    return nil;
}
- (NSUInteger)countOfList {
    return [self.masterBrewMethodList count];
}
- (BrewMethod *) objectInListAtIndex:(NSUInteger)theIndex{
    return [self.masterBrewMethodList objectAtIndex:theIndex];
}
- (BrewMethod *) findMethod:(NSString *)theName{
    BrewMethod *method = nil;
    for (int i = 0; i < self.masterBrewMethodList.count; i++) {
        if ([self objectInListAtIndex:i].name == theName) {
            method = [self objectInListAtIndex:i];
        }
    }
    return method;
}
-(void)addBrewMethodWithBrewMethod:(BrewMethod *)method{
    [self.masterBrewMethodList addObject:method];
}
@end
