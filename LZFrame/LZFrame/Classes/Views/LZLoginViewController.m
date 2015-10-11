//
//  LZLoginViewController.m
//  LZFrame
//
//  Created by comst on 15/10/11.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZLoginViewController.h"
#import "AppDelegate.h"
#import "LZLoginRequest.h"
#import "LZGlobal.h"
@interface LZLoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *userpasswordTextfield;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userpasswordTextfield.delegate = self;
    self.usernameTextfield.delegate = self;
    // Do any additional setup after loading the view.
    
}



#pragma mark - button click action

- (IBAction)loginbtnClick:(UIButton *)sender {
    if ([self.usernameTextfield.text length] == 0 || [self.userpasswordTextfield.text length] == 0) {
        return;
    }
    LZLoginRequest *loginRequest = [[LZLoginRequest alloc] init];
    
    [loginRequest sendLoginRequestWithName:self.usernameTextfield.text password:self.userpasswordTextfield.text completeblock:^(LZUserInfo *user, NSError *error) {
        
        if (!error) {
            
            [LZGlobal sharedglobal].userinfo = user;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [UIView animateWithDuration:1 animations:^{
                    self.view.alpha = 0.3;
                } completion:^(BOOL finished) {
                    
                    AppDelegate *appDel =  [UIApplication sharedApplication].delegate ;
                    
                    [appDel loadUserInfo];
                    
                }];
                
                
            }];
        }
        
    }];
}

#pragma mark - textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
