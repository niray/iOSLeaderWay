//
//  ViewController.m
//  LeaningWay
//
//  Created by Huway Mac on 16/4/6.
//  Copyright © 2016年 Android Develope. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lbl_question;
@property (weak, nonatomic) IBOutlet UILabel *lbl_answer;
 

@property (weak, nonatomic) IBOutlet UIButton *btn_question;
@property (weak, nonatomic) IBOutlet UIButton *btn_show;

@property (nonatomic,copy) NSArray *questions;
@property (nonatomic,copy) NSArray *answers;

@property (nonatomic) int currentQuestionIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.questions = @[@"From what is coganc made?",
                       @"What is 7+7?",
                       @"What is the capital of Vermont?"];
    
    self.answers = @[@"Grapes",
                     @"14",
                     @"Montpeli	er"];
    
    int randomValue = arc4random() % 100;
    
    NSLog(@"randonInt %@",self.questions[randomValue%[self.questions count]]);
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}




- (IBAction)onQuestionClick:(id)sender {
    //next question
    self.currentQuestionIndex++;
    
    if(self.currentQuestionIndex==[self.questions count]){
        //return 1st question
        self.currentQuestionIndex=0;
    }
    
    NSString *question = self.questions[self.currentQuestionIndex];
    
    self.lbl_question.text=question;
    
    self.lbl_answer.text = @"???";
    
    
}
- (IBAction)onAnswerShowClick:(id)sender {
   // UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Title" message:@"Content" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:@"13",@"2",nil ];
   // [av show];
    self.lbl_answer.text = self.answers[self.currentQuestionIndex];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"index %d",(int)buttonIndex);
}
@end
