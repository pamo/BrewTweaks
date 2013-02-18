//
//  BrewMethodDetailViewController.h
//  BrewTweaks
//
//  Created by Pamela Ocampo on 2/17/13.
//  Copyright (c) 2013 Pamela Ocampo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BrewMethod;
@interface BrewMethodDetailViewController : UIViewController

@property (strong, nonatomic) BrewMethod *brewMethod;
@property (weak, nonatomic) IBOutlet UILabel *brewMethodNameLabel;
@end