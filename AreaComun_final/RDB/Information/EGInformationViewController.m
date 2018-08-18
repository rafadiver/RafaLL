//
//  EGInformationViewController.m
//  RDB
//
//  Created by Hugo M Morales Hdez on 18/03/18.
//  Copyright © 2018 AutoChilango. All rights reserved.
//

#import "EGInformationViewController.h"
#import "EGGlobalValueStorageUtilities.h"
#import "EGOnBoardingInitViewController.h"
#import "EGDataGraphicsViewController.h"
#import "ACBuildingsLocationViewController.h"


@interface EGInformationViewController ()

@end

@implementation EGInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self checkupUser];
    
    
}

-(void)checkupUser {
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"eg_first_user"] isEqual:@YES]) {
        
        [self showOnBoarding];
        
    } else {
        
        NSLog(@"Must be a common user");
        
    }
    
}

- (void) showOnBoarding {
    UIStoryboard *storyboard = self.storyboard;
    EGOnBoardingInitViewController * onBoardingViewController = [storyboard instantiateViewControllerWithIdentifier:@"EGOnBoardingInitViewController"];
    [onBoardingViewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:onBoardingViewController animated:YES completion:NULL];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToGraphics:(id)sender {
    
    NSLog(@"%ld", (long)[sender tag]);
    
//    UIStoryboard *storyboard = self.storyboard;
//    EGDataGraphicsViewController * dataVC = [storyboard instantiateViewControllerWithIdentifier:@"EGDataGraphicsViewController"];
//    [dataVC initVCWithData:[self setUpTransferData:[sender tag]]];
//    [self.navigationController pushViewController:dataVC animated:YES];
//
    UIStoryboard *storyboard = self.storyboard;
    ACBuildingsLocationViewController * dataVC = [storyboard instantiateViewControllerWithIdentifier:@"ACBuildingsLocationViewController"];
//    [dataVC initVCWithData:[self setUpTransferData:[sender tag]]];
    [self.navigationController pushViewController:dataVC animated:YES];
    
}

-(NSMutableArray *)setUpTransferData:(NSUInteger)value {
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
   
    NSLog(@"%@",array);
    
    switch (value) {
        case 1:
            [array addObject:@"Agregar un edificio"];
            [array addObject:@"alguna cadena testing"];
            return array;
        break;
        case 2:
            [array addObject:@"Checar alguna zona"];
            [array addObject:@"alguna cadena testing"];
            return array;
            break;
        case 3:
            [array addObject:@"Hablar con mi Administrador"];
            [array addObject:@"alguna cadena testing"];
            return array;
            break;
        case 4:
            [array addObject:@"Contáctanos"];
            [array addObject:@"alguna cadena testing"];
            return array;
            break;
        case 5:
            [array addObject:@"SALUD FÍSICA"];
            [array addObject:@"alguna cadena testing"];
            return array;
            break;
        case 6:
            [array addObject:@"SALUD MENTAL"];
            [array addObject:@"alguna cadena testing"];
            return array;
            break;
        case 7:
            [array addObject:@"MANEJO DE ESTRÉS"];
            [array addObject:@"alguna cadena testing"];
            return array;
            break;
        default:
            break;
    }
    
    return nil;
}


@end
