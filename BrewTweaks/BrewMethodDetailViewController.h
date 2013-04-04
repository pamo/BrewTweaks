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
@class BrewMethodDataController;

@interface BrewMethodDetailViewController : UITableViewController <DoneCancelNumberPadToolbarDelegate, UITextFieldDelegate>


@property (strong, nonatomic) BrewMethod *brewMethod;
@property (strong, nonatomic) BrewMethodDataController *dataController;

@property (weak, nonatomic) IBOutlet UILabel *grindSizeLabel;
@property (weak, nonatomic) IBOutlet UITextField *waterAmountInput;
@property (weak, nonatomic) IBOutlet UITextField *coffeeAmountInput;
@property (weak, nonatomic) IBOutlet UITextField *tempInput;
@property (weak, nonatomic) IBOutlet UITextField *ratioInput;
@property (weak, nonatomic) IBOutlet UISegmentedControl *waterUnits;
@property (weak, nonatomic) IBOutlet UISegmentedControl *coffeeUnits;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tempUnits;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *resetButton;
@property NSMutableArray *grindTypes;
@property BOOL coffeeChanged;
@property BOOL waterChanged;
@property BOOL ratioChanged;

-(IBAction)coffeeUnitChanged;
-(IBAction)waterUnitChanged;
-(IBAction)tempUnitChanged;
-(IBAction)valueChanged:(UITextField *) textField;
-(IBAction)reloadValues;
@end