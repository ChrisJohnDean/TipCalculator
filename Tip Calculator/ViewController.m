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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    self.didEnterTipPercentage = YES;

}

-(void)keyboardDidShow:(NSNotification*)notification {
    
    [UIView animateWithDuration:2 animations:^{
        [self.view setFrame:CGRectOffset(self.view.frame, 0, -100)];
    }];
}

-(void)keyboardDidHide:(NSNotification*)notification {
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setFrame:CGRectOffset(self.view.frame, 0, 100)];
    }];
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

- (IBAction)adjustTipPercentage:(UISlider*)sender {
    float tipPercentage = sender.value/100;
    self.tipPercentageTextField.text = [NSString stringWithFormat:@" %.1f", [sender value]];
    NSString *billAmount = self.billAmountTextField.text;
    float billFloatAmount = [billAmount floatValue];
    float tipAmount = billFloatAmount*tipPercentage;
    self.tipAmountLabel.text = [NSString stringWithFormat:@"$%.02f", tipAmount];
}


@end
