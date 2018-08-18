//
//  EGOnBoardingInitViewController.m
//  RDB
//
//  Created by Hugo M Morales Hdez on 18/03/18.
//  Copyright © 2018 AutoChilango. All rights reserved.
//

#import "EGOnBoardingInitViewController.h"
#import "EGOnBoardingPageViewController.h"
#import "EchaleGalleta-Prefix.pch"
#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface EGOnBoardingInitViewController () <EGOnBoardingDelegate>

@property(nonatomic) AppDelegate *appDelegate;

@end

@implementation EGOnBoardingInitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialize];
    
}

-(void) initialize {
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setTextToOnBoarding];
    [self initPageController];
}

-(void) setTextToOnBoarding {
    self.pageTitles = @[
                        @"¿Cansado de no poder comunicarse\n entre vecinos?",
                        @"¿Has tenido necesidad de comunicarte con alguien\n y no pudiste hacerlo por qué tu proveedor de internet\n está fallando?",
                        @"¡Únete a la comunidad vecinal más importante de México!"];
    
    self.pageImages = @[@"map",
                        @"community",
                        @"buildings"];
    
    self.pageButtonTitles = @[@"",
                              @"ACCESO A MI UBICACIÓN",
                              @"QUIERO NOTIFICACIONES"];
    
    self.pageSecondButtonTitles = @[
                                    @"Checa cómo esta la aplicación",
                                    @"Quiero buscar yo los edificios",
                                    @"Por el momento no quiero, gracias"];
}

-(void)initPageController {
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EGOnBoardingPageViewController"];
    self.pageViewController.dataSource = self;
    
    EGOnBoardingPageViewController *startingViewController = (EGOnBoardingPageViewController *)[self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}

-(EGOnBoardingContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    EGOnBoardingContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EGOnBoardingContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.titleTextButton = self.pageButtonTitles[index];
    pageContentViewController.secondTitleTextButton = self.pageSecondButtonTitles[index];
    pageContentViewController.pageIndex = index;
    pageContentViewController.delegate = self;
    
    return pageContentViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegates
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((EGOnBoardingContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((EGOnBoardingContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

#pragma mark - PageIndicator
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

#pragma mark - Page ViewController

- (void) goToPage:(NSInteger)page
{
    EGOnBoardingContentViewController *startingViewController = [self viewControllerAtIndex:page];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void) dismissOnBoarding {
    
//    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
//    [ud setObject:@YES forKey:@"onboarding_showed"];
//    [ud setObject:@YES forKey:@"firstAddPlate"];
//    [ud synchronize];
    
//    if ([[ACPersistentData sharedManager] datosGuardados].count == 0 && [[NSUserDefaults standardUserDefaults] objectForKey:@"onboarding_showed"]) {
//
//        [[SettingsGlobalProperties sharedManager] setEnableReminderAddPlate:TRUE];
//        [ACNotification createAddPlateReminder];
//
//    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        NSLog(@"Dismiss ADD PLATE");
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOW_ONLY_ADDPLATE" object:nil];
    }];
}

#pragma mark - OnBoarding Delegate
-(void)performAction:(NSInteger)action {
    
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    if (action == ONBOARDING_ACTION_ASK_NOTIFICATION) {

        UNAuthorizationOptions authOptions = (UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound);
        
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
            if (granted) {
                [[UIApplication sharedApplication] registerForRemoteNotifications];
//                [ud setBool:granted forKey:@"notification_authorization"];
//                [ud setBool:granted forKey:@"historic_permission"];
//                [ud setBool:granted forKey:@"first_permission"];
                
                
            } else {
//                [ud setBool:granted forKey:@"notification_authorization"];
//                [ud setBool:granted forKey:@"historic_permission"];
//                [ud setBool:granted forKey:@"first_permission"];
            }
            
            [ud synchronize];
            [self dismissOnBoarding];
            [self goToPage:2];
            
        }];
        
    } else if (action == ONBOARDING_ACTION_ASK_LOCATION) {
        //        [self dismissOnBoarding];
        [self askForLocationPermissions];
        [self goToPage:2];
    } else if (action == ONBOARDING_ACTION_ASK_NOTIFICATION) {
        //        [self goToPage:2];
        [self dismissOnBoarding];
    } else if (action == ONBOARDING_ACTION_DONT_ASK_LOCATION) {
        //        [self askForLocationPermissions];
        [self goToPage:2];
        //        [self dismissOnBoarding];
    } else if(action == ONBOARDING_ACTION_DONT_ASK_NOTIFICATION) {
        [self dismissOnBoarding];
    }
    
}

- (void) askForLocationPermissions {
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization]; //or requestWhenInUseAuthorization
        
    }
}

@end
