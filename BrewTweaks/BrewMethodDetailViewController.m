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
    self.grindTypes = [NSMutableArray arrayWithObjects: @"Coarse", @"Medium-Coarse", @"Medium",  @"Medium-Fine", @"Fine", nil];
    
    if (theBrewMethod) {
        
        theBrewMethod.waterUnit = self.waterUnits.selectedSegmentIndex;
        theBrewMethod.coffeeUnit = self.coffeeUnits.selectedSegmentIndex;
        theBrewMethod.tempUnit = self.tempUnits.selectedSegmentIndex;

        self.navigationItem.title = theBrewMethod.name;
        self.grindSizeLabel.text = theBrewMethod.grind;
        self.waterAmountInput.text = [NSString stringWithFormat:@"%.0lf", theBrewMethod.waterAmount];
        self.coffeeAmountInput.text = [NSString stringWithFormat:@"%.0lf", theBrewMethod.coffeeAmount];
        self.tempInput.text = [NSString stringWithFormat:@"%.0lf", theBrewMethod.temp];
        
        self.ratioInput.text = [NSString stringWithFormat:@"%.2lf", [self calculateRatio:theBrewMethod.waterAmount coffee:theBrewMethod.coffeeAmount units:0]];
        
        DoneCancelNumberPadToolbar *waterDecimalToolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:self.waterAmountInput withKeyboardType:UIKeyboardTypeDecimalPad];
        self.waterAmountInput.inputAccessoryView = waterDecimalToolbar;
        
        DoneCancelNumberPadToolbar *coffeeDecimalToolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:self.coffeeAmountInput withKeyboardType:UIKeyboardTypeDecimalPad];
        self.coffeeAmountInput.inputAccessoryView = coffeeDecimalToolbar;
        
        DoneCancelNumberPadToolbar *tempDecimalToolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:self.tempInput withKeyboardType:UIKeyboardTypeDecimalPad];
        self.tempInput.inputAccessoryView = tempDecimalToolbar;
        
        DoneCancelNumberPadToolbar *ratioDecimalToolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:self.ratioInput withKeyboardType:UIKeyboardTypeDecimalPad];
        self.ratioInput.inputAccessoryView = ratioDecimalToolbar;
        
        waterDecimalToolbar.delegate = self;
        coffeeDecimalToolbar.delegate = self;
        tempDecimalToolbar.delegate = self;
        ratioDecimalToolbar.delegate = self;

    }
    
    
}
-(double)calculateRatio:(double) water coffee:(double) coffee units:(int)units{
    switch (units) {
        case 0:
            water = water/28.0;
            break;
        default:
            break;
    }
    self.brewMethod.ratio = coffee/water;
    self.ratioInput.text = [NSString stringWithFormat:@"%.2lf", self.brewMethod.ratio];

    return self.brewMethod.ratio;
    
}
-(double)calculateWater:(double)coffee ratio:(double) ratio{
    if (self.coffeeUnits.selectedSegmentIndex == 0) {
        coffee = coffee*28.0;
    }
    
    // water is in ounces
    self.brewMethod.waterAmount = coffee/ratio;
    self.waterAmountInput.text = [NSString stringWithFormat:@"%.2lf", self.brewMethod.waterAmount];
    
    // If grams are selected, convert
    if (self.waterUnits.selectedSegmentIndex == 0) {
        self.brewMethod.waterAmount = self.brewMethod.waterAmount*28.0;
        self.waterAmountInput.text = [NSString stringWithFormat:@"%.0lf", self.brewMethod.waterAmount];
    }
    
    return self.brewMethod.waterAmount;
}

-(double)calculateCoffee:(double)water ratio:(double) ratio{
    if (self.waterUnits.selectedSegmentIndex == 0) {
        water = water/28.0;
    }
    // coffee is in grams 
    self.brewMethod.coffeeAmount = water*ratio;
    self.coffeeAmountInput.text = [NSString stringWithFormat:@"%.0lf", self.brewMethod.coffeeAmount];
    
    // If ounces are selected, convert
    if (self.coffeeUnits.selectedSegmentIndex == 0) {
        self.brewMethod.coffeeAmount = self.brewMethod.coffeeAmount/28.0;
        self.coffeeAmountInput.text = [NSString stringWithFormat:@"%.2lf", self.brewMethod.coffeeAmount];
    }
    
    return self.brewMethod.coffeeAmount;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}
-(void)doneCancelNumberPadToolbarDelegate:(DoneCancelNumberPadToolbar *)controller didClickDone:(UITextField *)textField
{
    //NSLog(@"%@", textField.text);
}

-(void)doneCancelNumberPadToolbarDelegate:(DoneCancelNumberPadToolbar *)controller didClickCancel:(UITextField *)textField
{

    //NSLog(@"Old Text: %@, Canceled: %@", textField.text, [textField description]);
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
    NSLog(@"textFieldShouldEndEditing %@", textField.text);
    if(textField==self.waterAmountInput || textField==self.coffeeAmountInput || textField == self.tempInput){
        [self valueChanged:textField];
        [textField resignFirstResponder];
    }
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    if(textField==self.waterAmountInput || textField==self.coffeeAmountInput || textField == self.tempInput){
        [self valueChanged:textField];
        [textField resignFirstResponder];
    }
return YES;
}
-(IBAction)valueChanged:(UITextField *)textField{
    NSLog(@"%@ changed to %@", textField, textField.text);
    if(textField == self.waterAmountInput){
        self.brewMethod.waterAmount = textField.text.doubleValue;
        self.waterChanged = true;
        
    } else if (textField == self.coffeeAmountInput){
        self.brewMethod.coffeeAmount = textField.text.doubleValue;
        self.coffeeChanged = true;
        
    } else if (textField == self.tempInput){
        self.brewMethod.temp = textField.text.doubleValue;
    } else if (textField == self.ratioInput){
        self.brewMethod.ratio = textField.text.doubleValue;
        self.ratioChanged = true;
    }
    
    if (self.coffeeChanged && self.ratioChanged) {
        [self calculateWater:self.brewMethod.coffeeAmount ratio:self.brewMethod.ratio];
    } else if (self.coffeeChanged && self.waterChanged){
        [self calculateRatio:self.brewMethod.waterAmount coffee:self.brewMethod.coffeeAmount units:self.waterUnits.selectedSegmentIndex];
    } else if (self.waterChanged && self.ratioChanged){
        [self calculateCoffee:self.brewMethod.waterAmount ratio:self.brewMethod.ratio];
    }
}
-(IBAction)coffeeUnitChanged{
    // Get the current input value
    self.brewMethod.coffeeAmount = self.coffeeAmountInput.text.doubleValue;
    
    switch (self.coffeeUnits.selectedSegmentIndex) {
        case 0:
            // Convert to grams
            self.brewMethod.coffeeAmount = self.brewMethod.coffeeAmount*28.0;
            self.brewMethod.coffeeAmount = round(self.brewMethod.coffeeAmount*10.0)/10.0;

            self.coffeeAmountInput.text = [NSString stringWithFormat:@"%.0lf", self.brewMethod.coffeeAmount];
            break;
        case 1:
            // Convert to ounces
            self.brewMethod.coffeeAmount = self.brewMethod.coffeeAmount/28.0;
            self.coffeeAmountInput.text = [NSString stringWithFormat:@"%.2lf", self.brewMethod.coffeeAmount];
            break;
        default:
            self.coffeeAmountInput.text = [NSString stringWithFormat:@"%.2lf", self.brewMethod.coffeeAmount];
            break;
    }
    
    [self calculateRatio:self.brewMethod.waterAmount coffee:self.brewMethod.coffeeAmount units:self.waterUnits.selectedSegmentIndex];
    
}
-(IBAction)waterUnitChanged{
    self.brewMethod.waterAmount = self.waterAmountInput.text.doubleValue;
    switch (self.waterUnits.selectedSegmentIndex) {
        case 0:
            self.brewMethod.waterAmount = self.brewMethod.waterAmount*28.0;
            self.brewMethod.waterAmount = round(self.brewMethod.waterAmount*10.0)/10.0;
            self.waterAmountInput.text = [NSString stringWithFormat:@"%.0lf", self.brewMethod.waterAmount];
            break;
        case 1:
            self.brewMethod.waterAmount = self.brewMethod.waterAmount/28.0;
            self.waterAmountInput.text = [NSString stringWithFormat:@"%.2lf", self.brewMethod.waterAmount];
            break;
        default:
            self.waterAmountInput.text = [NSString stringWithFormat:@"%.2lf", self.brewMethod.waterAmount];
            break;
    }
    
    [self calculateRatio:self.brewMethod.waterAmount coffee:self.brewMethod.coffeeAmount units:self.waterUnits.selectedSegmentIndex];
}
-(IBAction)tempUnitChanged{
    self.brewMethod.temp = self.tempInput.text.doubleValue;
    switch (self.tempUnits.selectedSegmentIndex) {
        case 0:
            // Convert to Fahrenheit
            self.brewMethod.temp = (self.tempInput.text.doubleValue*1.8)+32;
            break;
        case 1:
            // Convert to Celsius
            self.brewMethod.temp = (self.tempInput.text.doubleValue-32)/1.8;
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
