//
//  EGOnBoardingContentViewController.h
//  RDB
//
//  Created by Hugo M Morales Hdez on 18/03/18.
//  Copyright © 2018 AutoChilango. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EGOnBoardingDelegate;

@protocol EGOnBoardingDelegate <NSObject>

@optional
- (void)performAction:(NSInteger)action;
@end


@interface EGOnBoardingContentViewController : UIViewController

@property (assign, nonatomic) id <EGOnBoardingDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *pageImageView;
@property (weak, nonatomic) IBOutlet UILabel *textPageLabel;
@property (weak, nonatomic) IBOutlet UIButton *pageButton;
@property (weak, nonatomic) IBOutlet UIButton *secondPageButton;

@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *titleTextButton;
@property NSString *secondTitleTextButton;
@property NSString *imageFile;

- (IBAction)pageAction:(id)sender;
- (IBAction)pageSecondAction:(id)sender;


@end
