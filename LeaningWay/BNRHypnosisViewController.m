//
//  BNRHypnosisViewController.m
//  LeaningWay
//
//  Created by Huway Mac on 16/4/18.
//  Copyright © 2016年 Android Develope. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "HypnosisView.h"

@interface BNRHypnosisViewController()<UITextFieldDelegate>
@end

@implementation BNRHypnosisViewController

-(void)loadView{
     HypnosisView *backgroudView = [[HypnosisView alloc] init];
    CGRect textFieldRect =CGRectMake(40, 70, 240, 30);
    UITextField *textField = [[UITextField alloc]initWithFrame: textFieldRect];
    textField.placeholder = @"Hypnotize me ";
    textField.returnKeyType=UIReturnKeyDone;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.delegate = self;
    
    
    [backgroudView addSubview:textField];
    
    self.view = backgroudView;

}

-(void) drawHypnoticMessage:(NSString*)message{
    for (int i = 0 ; i<20; i++) {
        UILabel *msgLbl = [[UILabel alloc]init];
        
        msgLbl.backgroundColor = [UIColor clearColor];
        msgLbl.textColor = [UIColor whiteColor];
        msgLbl.text = message;

        [msgLbl sizeToFit];

        int width = (int) (self.view.bounds.size.width - msgLbl.bounds.size.width);
        int x = arc4random() % width;

        int height = (int) (self.view.bounds.size.height - msgLbl.bounds.size.height);
        int  y = arc4random() % height;

        CGRect frame = msgLbl.frame;
        frame.origin = CGPointMake(x, y);
        msgLbl.frame = frame;

        [self.view addSubview:msgLbl];
        
        
        UIInterpolatingMotionEffect  *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [msgLbl addMotionEffect:motionEffect];

        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [msgLbl addMotionEffect:motionEffect];
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"%@", textField.text);
    [self drawHypnoticMessage:textField.text];
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}

//-(void)clearButtonTapped{
//    SEL clearSelector = @selector(textFieldShouldClear:);
//    if([self.delegate respondesToSelector:clearSelector]){
//        self.text="";
//    }
//}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.tabBarController.title=@"值得";
//        UIImage *i = [UIImage imageNamed:@"hs.jpg"];
//        self.tabBarItem.image=i;
    } 
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"BNRHypnosisViewController loaded its View");
}

@end
