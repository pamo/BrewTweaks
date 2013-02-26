//
//  BrewMethodDetailViewController.m
//  BrewTweaks
//
//  Created by Pamela Ocampo on 2/17/13.
//  Copyright (c) 2013 Pamela Ocampo. All rights reserved.
//

#import "BrewMethodDetailViewController.h"
#import "BrewMethod.h"
#include <math.h>

@interface BrewMethodDetailViewController ()
- (void)configureView;
@end

@implementation BrewMethodDetailViewController

#pragma mark - Managing the detail item

- (void)setBrewMethod:(BrewMethod *) newBrewMethod
{
    if (_brewMethod != newBrewMethod) {
        _brewMethod = newBrewMethod;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    BrewMethod *theBrewMethod = self.brewMethod;
    self.navigationItem.backBarButtonItem.title = @"Back";
    if (theBrewMethod) {
        
        theBrewMethod.waterUnit = self.waterUnits.selectedSegmentIndex;
        theBrewMethod.coffeeUnit = self.coffeeUnits.selectedSegmentIndex;
        theBrewMethod.tempUnit = self.tempUnits.selectedSegmentIndex;

        self.navigationItem.title = theBrewMethod.name;
        self.grindSizeLabel.text = theBrewMethod.grind;
        self.waterAmountInput.text = [NSString stringWithFormat:@"%.0lf", theBrewMethod.waterAmount];
        self.coffeeAmountInput.text = [NSString stringWithFormat:@"%.0lf", theBrewMethod.coffeeAmount];
        self.tempInput.text = [NSString stringWithFormat:@"%.0lf", theBrewMethod.temp];

    }
    
    DoneCancelNumberPadToolbar *waterDecimalToolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:self.waterAmountInput withKeyboardType:UIKeyboardTypeDecimalPad];
    self.waterAmountInput.inputAccessoryView = waterDecimalToolbar;
    
    DoneCancelNumberPadToolbar *coffeeDecimalToolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:self.coffeeAmountInput withKeyboardType:UIKeyboardTypeDecimalPad];
    self.coffeeAmountInput.inputAccessoryView = coffeeDecimalToolbar;
    
    DoneCancelNumberPadToolbar *tempDecimalToolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:self.tempInput withKeyboardType:UIKeyboardTypeDecimalPad];
    self.tempInput.inputAccessoryView = tempDecimalToolbar;
    waterDecimalToolbar.delegate = self;
    coffeeDecimalToolbar.delegate = self;
    tempDecimalToolbar.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}
-(void)doneCancelNumberPadToolbarDelegate:(DoneCancelNumberPadToolbar *)controller didClickDone:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
}

-(void)doneCancelNumberPadToolbarDelegate:(DoneCancelNumberPadToolbar *)controller didClickCancel:(UITextField *)textField
{
    NSLog(@"Canceled: %@", [textField description]);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {;

    if ((textField == self.waterAmountInput) || (textField == self.coffeeAmountInput) || (textField == self.tempInput)) {
        [textField resignFirstResponder];
    }
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField==self.waterAmountInput || textField==self.coffeeAmountInput || textField == self.tempInput){
        [self valueChanged:textField];
        [textField isFirstResponder];
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    //NSLog(@"textFieldShouldEndEditing %@", textField.text);
    if(textField==self.waterAmountInput || textField==self.coffeeAmountInput || textField == self.tempInput){
        [self valueChanged:textField];
        [textField resignFirstResponder];
    }
    return YES;
}
-(IBAction)valueChanged:(UITextField *)textField{
    //NSLog(@"Value changed to %@", textField.text);
    if(textField == self.waterAmountInput){
        self.brewMethod.waterAmount = textField.text.doubleValue;
        
    } else if (textField == self.coffeeAmountInput){
        self.brewMethod.coffeeAmount = textField.text.doubleValue;
        
    } else if (textField == self.tempInput){
        self.brewMethod.temp = textField.text.doubleValue;
    }
}
-(IBAction)coffeeUnitChanged{
    switch (self.coffeeUnits.selectedSegmentIndex) {
        case 0:
            //NSLog(@"Coffee units are in grams");
            self.brewMethod.coffeeAmount = self.brewMethod.coffeeAmount*28.0;
            // round to nearest 10th gram
            self.brewMethod.coffeeAmount = round(self.brewMethod.coffeeAmount*10.0)/10.0;
            self.coffeeAmountInput.text = [NSString stringWithFormat:@"%.0lf", self.brewMethod.coffeeAmount];
            break;
        case 1:
            //NSLog(@"Coffee units are in ounces");
            self.brewMethod.coffeeAmount = self.brewMethod.coffeeAmount/28.0;
            self.coffeeAmountInput.text = [NSString stringWithFormat:@"%.2lf", self.brewMethod.coffeeAmount];
            break;
        default:
            self.coffeeAmountInput.text = [NSString stringWithFormat:@"%.2lf", self.brewMethod.coffeeAmount];
            break;
    }
    
}
-(IBAction)waterUnitChanged{
    switch (self.waterUnits.selectedSegmentIndex) {
        case 0:
            //NSLog(@"Water units are in grams");
            self.brewMethod.waterAmount = self.brewMethod.waterAmount*28.0;
            // round to nearest 10th gram
            self.brewMethod.waterAmount = round(self.brewMethod.waterAmount*10.0)/10.0;
            self.waterAmountInput.text = [NSString stringWithFormat:@"%.0lf", self.brewMethod.waterAmount];
            break;
        case 1:
            //NSLog(@"Water units are in ounces");
            self.brewMethod.waterAmount = self.brewMethod.waterAmount/28.0;
            self.waterAmountInput.text = [NSString stringWithFormat:@"%.2lf", self.brewMethod.waterAmount];
            break;
        default:
            self.waterAmountInput.text = [NSString stringWithFormat:@"%.2lf", self.brewMethod.waterAmount];
            break;
    }
}
-(IBAction)tempUnitChanged{
    switch (self.tempUnits.selectedSegmentIndex) {
        case 0:
            //NSLog(@"Temperature is in Fahrenheit");
            self.brewMethod.temp = (self.brewMethod.temp*1.8)+32;
            break;
        case 1:
            //NSLog(@"Temperature is in Celsius");
            self.brewMethod.temp = (self.brewMethod.temp-32)/1.8;
            break;
        default:
            break;
    }
    // round to nearest 10th degree
    self.brewMethod.temp = round(self.brewMethod.temp * 10.0)/10.0;
    self.tempInput.text = [NSString stringWithFormat:@"%.0lf", self.brewMethod.temp];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.waterAmountInput endEditing:YES];
    [self.coffeeAmountInput endEditing:YES];
    [self.tempInput endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
@end
