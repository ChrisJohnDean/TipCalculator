//
//  ViewController.m
//  Tip Calculator
//
//  Created by Chris Dean on 2018-02-23.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;
@property (nonatomic) BOOL didEnterTipPercentage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.tipPercentageTextField setDelegate:self];
    self.tipPercentageTextField.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.didEnterTipPercentage = YES;
}

-(void)dismissKeyboard {
    [self.billAmountTextField resignFirstResponder];
    [self.tipPercentageTextField resignFirstResponder];
}

- (IBAction)calculateTip:(id)sender {
    float tipPercentage;
    
    if(self.didEnterTipPercentage) {
        tipPercentage = [self.tipPercentageTextField.text floatValue]/100;
    } else {
        tipPercentage = 0.15;
    }
    
    NSString *billAmount = self.billAmountTextField.text;
    float billFloatAmount = [billAmount floatValue];
    float tipAmount = billFloatAmount*tipPercentage;
    self.tipAmountLabel.text = [NSString stringWithFormat:@"$%.02f", tipAmount];
    
    self.didEnterTipPercentage = NO;
    self.tipPercentageTextField.text = @"";
}


@end
