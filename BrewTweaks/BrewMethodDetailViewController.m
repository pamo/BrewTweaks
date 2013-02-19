//
//  BrewMethodDetailViewController.m
//  BrewTweaks
//
//  Created by Pamela Ocampo on 2/17/13.
//  Copyright (c) 2013 Pamela Ocampo. All rights reserved.
//

#import "BrewMethodDetailViewController.h"
#import "BrewMethod.h"
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
    
    if (theBrewMethod) {
        
        theBrewMethod.waterUnit = self.waterUnits.selectedSegmentIndex;
        theBrewMethod.coffeeUnit = self.coffeeUnits.selectedSegmentIndex;
        theBrewMethod.tempUnit = self.tempUnits.selectedSegmentIndex;

        self.navigationItem.title = theBrewMethod.name;
        self.grindSizeLabel.text = theBrewMethod.grind;
        self.waterAmountInput.text = [NSString stringWithFormat:@"%.2lf", theBrewMethod.waterAmount];
        self.coffeeAmountInput.text = [NSString stringWithFormat:@"%.2lf", theBrewMethod.coffeeAmount];
        self.tempInput.text = [NSString stringWithFormat:@"%.2lf", theBrewMethod.temp];

    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ((textField == self.waterAmountInput) || (textField == self.coffeeAmountInput) || (textField == self.tempInput)) {
        [textField resignFirstResponder];
    }
    return YES;
}
-(IBAction)unitsChanged:(UISegmentedControl *)segmentedControl{
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            NSLog(@"Water units are in grams");
            break;
        case 1:
            NSLog(@"Water units are in ounces");
        default:
            break;
    }
}
@end
