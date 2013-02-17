//
//  BrewMethodDataController.h
//  BrewTweaks
//
//  Created by Pamela Ocampo on 2/17/13.
//  Copyright (c) 2013 Pamela Ocampo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BrewMethod;
@interface BrewMethodDataController : NSObject
@property (nonatomic, copy) NSMutableArray *masterBrewMethodList;
- (NSUInteger)countOfList;
- (BrewMethod *)objectInListAtIndex:(NSUInteger)theIndex;
- (void)addBrewMethodWithBrewMethod:(BrewMethod *)method;
@end

