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
        self.navigationItem.title = theBrewMethod.name;
        self.grindSizeLabel.text = theBrewMethod.grind;
        self.waterAmountInput.text = [NSString stringWithFormat:@"%f", theBrewMethod.waterAmount];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}
@end
