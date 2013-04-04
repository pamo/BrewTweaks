//
//  BrewMethodDetailViewController.m
//  BrewTweaks
//
//  Created by Pamela Ocampo on 2/17/13.
//  Copyright (c) 2013 Pamela Ocampo. All rights reserved.
//

#import "BrewMethodDetailViewController.h"
#import "BrewMethodDataController.h"
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
        [self.ratioInput setBackgroundColor:[UIColor whiteColor]];        
        
        DoneCancelNumberPadToolbar *waterDecimalToolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:self.waterAmountInput withKeyboardType:UIKeyboardTypeDecimalPad];
        self.waterAmountInput.inputAccessoryView = waterDecimalToolbar;
        
        DoneCancelNumberPadToolbar *coffeeDecimalToolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:self.coffeeAmountInput withKeyboardType:UIKeyboardTypeDecimalPad];
        self.coffeeAmountInput.inputAccessoryView = coffeeDecimalToolbar;
        
        DoneCancelNumberPadToolbar *tempDecimalToolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:self.tempInput withKeyboardType:UIKeyboardTypeDecimalPad];
        [tempDecimalToolbar.items[2] setTitle:@"Set"];
        self.tempInput.inputAccessoryView = tempDecimalToolbar;
        
        DoneCancelNumberPadToolbar *ratioDecimalToolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:self.ratioInput withKeyboardType:UIKeyboardTypeDecimalPad];
        self.ratioInput.inputAccessoryView = ratioDecimalToolbar;
        
        waterDecimalToolbar.delegate = self;
        coffeeDecimalToolbar.delegate = self;
        tempDecimalToolbar.delegate = self;
        ratioDecimalToolbar.delegate = self;

    }
    [self resetBooleans];
    
}
- (IBAction)reloadValues {
    NSLog(@"Reload table");
    [self configureView];
    
}
-(void) resetBooleans{
    NSLog(@"All booleans set to false");
    self.coffeeChanged = false;
    self.waterChanged = false;
    self.ratioChanged = false;
}
-(double)calculateRatio:(double) water coffee:(double) coffee units:(int)units{
    NSLog(@"Gimme ratio");
    [self.ratioInput setBackgroundColor:[UIColor yellowColor]];
    switch (units) {
        case 0:
            water = water/28.0;
            break;
        default:
            break;
    }
    self.brewMethod.ratio = coffee/water;
    self.ratioInput.text = [NSString stringWithFormat:@"%.2lf", self.brewMethod.ratio];
    NSLog(@"Gimme ratio %.2lf", self.brewMethod.ratio);
    return self.brewMethod.ratio;
    
}
-(double)calculateWater:(double)coffee ratio:(double) ratio{
    [self.waterAmountInput setBackgroundColor:[UIColor yellowColor]];
    if (self.coffeeUnits.selectedSegmentIndex == 1) {
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
    
    NSLog(@"Set water to %.0lf", self.brewMethod.waterAmount);
    return self.brewMethod.waterAmount;
}

-(double)calculateCoffee:(double)water ratio:(double) ratio{
    [self.coffeeAmountInput setBackgroundColor:[UIColor yellowColor]];
    if (self.waterUnits.selectedSegmentIndex == 0) {
        water = water/28.0;
    }
    // coffee is in grams 
    self.brewMethod.coffeeAmount = water*ratio;
    self.coffeeAmountInput.text = [NSString stringWithFormat:@"%.0lf", self.brewMethod.coffeeAmount];
    
    // If ounces are selected, convert
    if (self.coffeeUnits.selectedSegmentIndex == 1) {
        self.brewMethod.coffeeAmount = self.brewMethod.coffeeAmount/28.0;
        self.coffeeAmountInput.text = [NSString stringWithFormat:@"%.2lf", self.brewMethod.coffeeAmount];
    }
    
    NSLog(@"Gimme coffee %.0lf", self.brewMethod.coffeeAmount);
    return self.brewMethod.coffeeAmount;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}
-(void)doneCancelNumberPadToolbarDelegate:(DoneCancelNumberPadToolbar *)controller didClickDone:(UITextField *)textField
{
 
}

-(void)doneCancelNumberPadToolbarDelegate:(DoneCancelNumberPadToolbar *)controller didClickCancel:(UITextField *)textField
{

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {;

    if ((textField == self.waterAmountInput) || (textField == self.coffeeAmountInput) || (textField == self.tempInput || textField == self.ratioInput)) {

        [textField resignFirstResponder];
    }
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField==self.waterAmountInput || textField==self.coffeeAmountInput || textField == self.tempInput || textField == self.ratioInput){
        [textField setBackgroundColor:[UIColor whiteColor]];
        [textField isFirstResponder];
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if(textField==self.waterAmountInput || textField==self.coffeeAmountInput || textField == self.tempInput || textField == self.ratioInput){
        [self valueChanged:textField];
        [textField resignFirstResponder];
    }
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    NSLog(@"Texfield cleared");
    if(textField==self.waterAmountInput || textField==self.coffeeAmountInput || textField == self.tempInput || textField == self.ratioInput){
        
        [textField resignFirstResponder];
    }
return YES;
}
-(IBAction)valueChanged:(UITextField *)textField{

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
    NSLog(@"\n%@ Changed\n  ########## Boolean Values ########## \nWater %d Coffee %d Ratio %d", textField.restorationIdentifier, self.waterChanged, self.coffeeChanged, self.ratioChanged);
    NSLog(@"\n########## Input Values ########## \nRatio: %.2lf, Water: %.2lf, Coffee: %.2lf", self.brewMethod.ratio, self.brewMethod.waterAmount, self.brewMethod.coffeeAmount);
    
    if (self.coffeeChanged == true && self.ratioChanged == true) {
        NSLog(@"Gimme water!");
        [self calculateWater:self.brewMethod.coffeeAmount ratio:self.brewMethod.ratio];
        self.coffeeChanged = false;
        self.ratioChanged = false;
        [self.coffeeAmountInput setBackgroundColor:[UIColor whiteColor]];
        [self.ratioInput setBackgroundColor:[UIColor whiteColor]];
    } else if (self.coffeeChanged == true && self.waterChanged == true){
        [self calculateRatio:self.brewMethod.waterAmount coffee:self.brewMethod.coffeeAmount units:self.waterUnits.selectedSegmentIndex];
        self.coffeeChanged = false;
        self.waterChanged = false;
        [self.coffeeAmountInput setBackgroundColor:[UIColor whiteColor]];
        [self.waterAmountInput setBackgroundColor:[UIColor whiteColor]];
    } else if (self.waterChanged == true && self.ratioChanged == true){
        [self calculateCoffee:self.brewMethod.waterAmount ratio:self.brewMethod.ratio];
        self.waterChanged = false;
        self.ratioChanged = false;
        [self.waterAmountInput setBackgroundColor:[UIColor whiteColor]];
        [self.ratioInput setBackgroundColor:[UIColor whiteColor]];        
    } else if (self.waterChanged && !self.ratioChanged && !self.coffeeChanged){
        [self calculateCoffee:self.brewMethod.waterAmount ratio:self.brewMethod.ratio];
    } else if (self.coffeeChanged && !self.ratioChanged && !self.waterChanged){
        [self calculateWater:self.brewMethod.coffeeAmount ratio:self.brewMethod.ratio];
    }
    NSLog(@"\nBoolean Reset: Water %d Coffee %d Ratio %d", self.waterChanged, self.coffeeChanged, self.ratioChanged);
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
