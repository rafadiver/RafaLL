//
//  ACBuildingsLocationViewController.h
//  RDB
//
//  Created by Hugo M Morales Hdez on 23/04/18.
//  Copyright © 2018 AutoChilango. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ACBuildingsLocationViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *buildingMapping;

@end
