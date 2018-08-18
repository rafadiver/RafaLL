//
//  EGQuizViewController.h
//  RDB
//
//  Created by Hugo M Morales Hdez on 19/03/18.
//  Copyright © 2018 AutoChilango. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EGQuizViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextView *samplesQuiz;

@property (weak, nonatomic) IBOutlet UIView *pickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerQuiz;

-(void) initVCWithData:(NSMutableArray *)data;

- (IBAction)showPicker:(id)sender;

@end
