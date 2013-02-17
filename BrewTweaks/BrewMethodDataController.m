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
    self.masterBrewMethodList = methodList;
    BrewMethod *method;
    
    method = [[BrewMethod alloc] initWithName:@"French Press"];
    [self addBrewMethodWithBrewMethod:method];
    
    method = [[BrewMethod alloc] initWithName:@"Moka Pot"];
    [self addBrewMethodWithBrewMethod:method];
    
    method = [[BrewMethod alloc] initWithName:@"Chemex"];
    [self addBrewMethodWithBrewMethod:method];
    
    method = [[BrewMethod alloc] initWithName:@"AeroPress"];
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
-(void)addBrewMethodWithBrewMethod:(BrewMethod *)method{
    [self.masterBrewMethodList addObject:method];
}
@end
