//
//  EGOnBoardingContentViewController.m
//  RDB
//
//  Created by Hugo M Morales Hdez on 18/03/18.
//  Copyright © 2018 AutoChilango. All rights reserved.
//

#import "EGOnBoardingContentViewController.h"
#import "EchaleGalleta-Prefix.pch"

@interface EGOnBoardingContentViewController ()

@end

@implementation EGOnBoardingContentViewController

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
    
    [self.pageButton setHidden:(self.pageIndex == 0) ? YES: NO];
    [self.secondPageButton setEnabled:self.pageIndex == 0 ? NO: YES];
    
    [self.pageImageView setImage:[UIImage imageNamed:self.imageFile]];
    self.textPageLabel.text = self.titleText;
    [self.pageButton setTitle:self.titleTextButton forState:UIControlStateNormal];
    [self.secondPageButton setTitle:self.secondTitleTextButton forState:UIControlStateNormal];
    
    self.secondPageButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.secondPageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (IBAction)pageAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(performAction:)]) {
        // notification permission allowed
        if (self.pageIndex == 1) {
            [self.delegate performAction:ONBOARDING_ACTION_ASK_NOTIFICATION];
            
            // location permission allowed
        } else if (self.pageIndex == 2) {
            [self.delegate performAction:ONBOARDING_ACTION_ASK_LOCATION];
        }
    }
    
}

- (IBAction)pageSecondAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(performAction:)]) {
        // notification permission allowed
        if (self.pageIndex == 1) {
            [self.delegate performAction:ONBOARDING_ACTION_DONT_ASK_NOTIFICATION];
            
            // location permission allowed
        } else if (self.pageIndex == 2) {
            [self.delegate performAction:ONBOARDING_ACTION_DONT_ASK_LOCATION];
        }
    }
    
}
@end
