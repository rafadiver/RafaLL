//
//  EGDataGraphicsViewController.h
//  RDB
//
//  Created by Hugo M Morales Hdez on 19/03/18.
//  Copyright © 2018 AutoChilango. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChartDelegate.h"
#import "PNChart/PNChart.h"

@interface EGDataGraphicsViewController : UIViewController <PNChartDelegate>

@property (nonatomic) PNBarChart * barChart;
@property (weak, nonatomic) IBOutlet UIView *graphicUIView;

@property (weak, nonatomic) IBOutlet UILabel *titleUILabel;
@property (weak, nonatomic) IBOutlet UITextView *definition;

-(void) initVCWithData:(NSMutableArray *)data;

@end
