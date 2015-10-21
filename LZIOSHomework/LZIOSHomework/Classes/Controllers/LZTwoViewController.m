//
//  LZTwoViewController.m
//  LZDemon1
//
//  Created by comst on 15/9/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZTwoViewController.h"

@interface LZTwoViewController ()<UITextFieldDelegate, UITextViewDelegate>
@property (nonatomic, weak) UITextField *txtfield;
@property (nonatomic, weak) UITextView *txtview;
@end

@implementation LZTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *img = [UIImage imageNamed:@"bg2"];
    self.imgView.image = img;
   
    self.navigationItem.title = @"Two";
    
    UITextField *textfield = [[UITextField alloc] init];
    
    self.txtfield = textfield;
    
    textfield.translatesAutoresizingMaskIntoConstraints = NO;
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    textfield.placeholder = @"hello world";
    textfield.textAlignment = NSTextAlignmentCenter;
    textfield.font = [UIFont systemFontOfSize:17];
    textfield.textColor = [UIColor colorWithRed:0.3 green:0.5 blue:0.7 alpha:1];
    textfield.returnKeyType = UIReturnKeyDone;
    textfield.keyboardType = UIKeyboardTypeAlphabet;
    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    textfield.delegate = self;
    
    UITextView *textview = [[UITextView alloc] init];
    
    self.txtview = textview;
    
    textview.translatesAutoresizingMaskIntoConstraints = NO;
    textview.delegate = self;
    textview.font = [UIFont systemFontOfSize:20];
    textview.textColor = [UIColor colorWithRed:0.1 green:0.8 blue:0.4 alpha:1];
    
    
    [self.view addSubview:textfield];
    [self.view addSubview:textview];
    
    NSDictionary *dict = @{@"textfield":textfield, @"textview":textview};
    NSString *textfieldVFLH = @"H:|-20-[textfield]-20-|";
    NSString *textviewVFLH = @"H:|-20-[textview]-20-|";
    NSString *VFLV = @"V:|-120-[textfield(==50)]-30-[textview(==100)]";
    NSArray *textfieldConstraintsH = [NSLayoutConstraint constraintsWithVisualFormat:textfieldVFLH options:0 metrics:nil views:dict];
    NSArray *textviewConstrainsH = [NSLayoutConstraint constraintsWithVisualFormat:textviewVFLH options:0 metrics:nil views:dict];
    NSArray *constraintsV = [NSLayoutConstraint constraintsWithVisualFormat:VFLV options:0 metrics:nil views:dict];
    
    [self.view addConstraints:textfieldConstraintsH];
    [self.view addConstraints:textviewConstrainsH];
    [self.view addConstraints:constraintsV];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self.txtview becomeFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"%@, (%ld, %ld )", string, range.location, range.length);
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"%s", __func__);
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"%s", __func__);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"%s", __func__);
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"%s", __func__);
    return YES;
}

#pragma mark - textview delegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
