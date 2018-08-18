//
//  EGOnBoardingInitViewController.h
//  RDB
//
//  Created by Hugo M Morales Hdez on 18/03/18.
//  Copyright © 2018 AutoChilango. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOnBoardingContentViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface EGOnBoardingInitViewController : UIViewController <UIPageViewControllerDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *background;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;
@property (strong, nonatomic) NSArray *pageButtonTitles;
@property (strong, nonatomic) NSArray *pageSecondButtonTitles;

@property (strong, nonatomic) CLLocationManager *locationManager;


@end
