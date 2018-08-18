//
//  EGQuizViewController.m
//  RDB
//
//  Created by Hugo M Morales Hdez on 19/03/18.
//  Copyright © 2018 AutoChilango. All rights reserved.
//

#import "EGQuizViewController.h"

@interface EGQuizViewController () {
    NSArray *pickerData;
}

@end

@implementation EGQuizViewController {
    
    NSString *rules;
    
}

-(void) initVCWithData:(NSMutableArray *)data {
    
    rules = data[0];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialize];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initialize {
    
    pickerData = [[NSArray alloc] init];
    
    [self.pickerView setHidden:TRUE];
    self.samplesQuiz.text = rules;
    pickerData = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    
    
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return pickerData[row];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
}

- (IBAction)showPicker:(id)sender {
    
    [self.pickerView setHidden:FALSE];
    
}

- (IBAction)closePicker:(id)sender {
    [self.pickerView setHidden:TRUE];
}

#pragma mark - Delegates



@end
