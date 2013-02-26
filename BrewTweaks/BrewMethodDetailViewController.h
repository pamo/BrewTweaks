//
//  BrewMethodDetailViewController.h
//  BrewTweaks
//
//  Created by Pamela Ocampo on 2/17/13.
//  Copyright (c) 2013 Pamela Ocampo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoneCancelNumberPadToolbar.h"

@class BrewMethod;
@interface BrewMethodDetailViewController : UITableViewController <DoneCancelNumberPadToolbarDelegate>


@property (strong, nonatomic) BrewMethod *brewMethod;

@property (weak, nonatomic) IBOutlet UILabel *grindSizeLabel;
@property (weak, nonatomic) IBOutlet UITextField *waterAmountInput;
@property (weak, nonatomic) IBOutlet UITextField *coffeeAmountInput;
@property (weak, nonatomic) IBOutlet UITextField *tempInput;
@property (weak, nonatomic) IBOutlet UISegmentedControl *waterUnits;
@property (weak, nonatomic) IBOutlet UISegmentedControl *coffeeUnits;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tempUnits;

-(IBAction)coffeeUnitChanged;
-(IBAction)waterUnitChanged;
-(IBAction)tempUnitChanged;
-(IBAction)valueChanged:(UITextField *) textField;
@end