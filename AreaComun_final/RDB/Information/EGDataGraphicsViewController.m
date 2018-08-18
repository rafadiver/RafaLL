//
//  EGDataGraphicsViewController.m
//  RDB
//
//  Created by Hugo M Morales Hdez on 19/03/18.
//  Copyright © 2018 AutoChilango. All rights reserved.
//

#import "EGDataGraphicsViewController.h"
#import "EGQuizViewController.h"

@interface EGDataGraphicsViewController () {
    
    NSString *titleUINS;
    NSString *definitionUINS;
    
}

@end

@implementation EGDataGraphicsViewController

-(void) initVCWithData:(NSMutableArray *)data {

    titleUINS = data[0];
    definitionUINS = data[1];
    
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

-(void) initialize {
    
    self.titleUILabel.text = titleUINS;
    self.definition.text = [NSString stringWithFormat:@"%@ es %@", titleUINS, definitionUINS];
    
    static NSNumberFormatter *barChartFormatter;
    if (!barChartFormatter) {
        barChartFormatter = [[NSNumberFormatter alloc] init];
        barChartFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
        barChartFormatter.allowsFloats = NO;
        barChartFormatter.maximumFractionDigits = 0;
    }
//    self.titleLabel.text = @"Bar Chart";
    
    self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 0.0, SCREEN_WIDTH, 200.0)];
    //        self.barChart.showLabel = NO;
    self.barChart.yLabelFormatter = ^(CGFloat yValue) {
        return [barChartFormatter stringFromNumber:@(yValue)];
    };
    
    self.barChart.yChartLabelWidth = 20.0;
    self.barChart.chartMarginLeft = 30.0;
    self.barChart.chartMarginRight = 10.0;
    self.barChart.chartMarginTop = 5.0;
    self.barChart.chartMarginBottom = 10.0;
    
    
    self.barChart.labelMarginTop = 5.0;
    self.barChart.showChartBorder = YES;
    [self.barChart setXLabels:@[@"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"]];
    //       self.barChart.yLabels = @[@-10,@0,@10];
    //        [self.barChart setYValues:@[@10000.0,@30000.0,@10000.0,@100000.0,@500000.0,@1000000.0,@1150000.0,@2150000.0]];
    [self.barChart setYValues:@[@10.82, @1.88, @6.96, @33.93, @10.82, @1.88, @6.96, @33.93]];
    [self.barChart setStrokeColors:@[PNGreen, PNGreen, PNRed, PNGreen, PNGreen, PNGreen, PNRed, PNGreen]];
    self.barChart.isGradientShow = NO;
    self.barChart.isShowNumbers = NO;
    
    [self.barChart strokeChart];
    
    self.barChart.delegate = self;
    
    [self.graphicUIView addSubview:self.barChart];
}

- (IBAction)goToQuiz:(id)sender {
    
    NSLog(@"%ld", (long)[sender tag]);
    
    NSInteger whatSection = [self whatSection:titleUINS];
    
    UIStoryboard *storyboard = self.storyboard;
    EGQuizViewController * dataVC = [storyboard instantiateViewControllerWithIdentifier:@"EGQuizViewController"];
    [dataVC initVCWithData:[self setUpTransferData:whatSection]];
    [self.navigationController pushViewController:dataVC animated:YES];
    
}

-(NSUInteger)whatSection:(NSString *)section {
    
    if ([section isEqualToString:@"Agregar un edificio"]) {
        return 1;
    } else if ([section isEqualToString:@"Checar alguna zona"]) {
        return 2;
    } else if ([section isEqualToString:@"Hablar con mi Administrador"]) {
        return 3;
    } else if ([section isEqualToString:@"Contáctanos"]) {
        return 4;
    } else if ([section isEqualToString:@"SALUD FÍSICA"]) {
        return 5;
    } else if ([section isEqualToString:@"SALUD MENTAL"]) {
        return 6;
    } else if ([section isEqualToString:@"MANEJO DE ESTRÉS"]) {
        return 7;
    } else {
        return 0;
    }
    
}

-(NSMutableArray *)setUpTransferData:(NSUInteger)value {
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    
    NSLog(@"%@",array);
    
    switch (value) {
        case 1:
            [array addObject:@"Elige metas realistas.\nPonle fecha a tus metas.\nVisualízate en el lugar y momento donde quieres llegar."];
            return array;
            break;
        case 2:
            [array addObject:@"Agradece diario a tu cuerpo tres cosas que hace por ti.\n¿Qué es lo que más te gusta de tu apariencia física?"];
            return array;
            break;
        case 3:
            [array addObject:@"Conoce los grupos de alimentos.\nIncluye un alimento de cada grupo en tus comidas principales\nDale variedad a tu dieta, prueba alimentos nuevos de cada grupo."];
            return array;
            break;
        case 4:
            [array addObject:@"Haz algo por alguien de manera desinteresada y sin esperar nada a cambio.\nEscucha activa: escuchar, comprender, empatizar con el otro ayuda a resolver el conflicto y fortalecer lazos afectivos.\nCuando saludes a alguien pregunta ¿Cómo te sientes?"];
            return array;
            break;
        case 5:
            [array addObject:@"Hazte un check up médico al año\nElige un hobbie donde tengas que mover el cuerpo."];
            return array;
            break;
        case 6:
            [array addObject:@"Haz una cronología de tu vida con los acontecimientos más importantes.\nLleva un diario personal.\nHabla con alguien de tus emociones de vez en cuando."];
            return array;
            break;
        case 7:
            [array addObject:@"Identifica la o las fuentes de estrés.\nHaz ejercicios de respiración.\nCanaliza esa energía, producida por el estrés, fuera de tu cuerpo."];
            return array;
            break;
        default:
            break;
    }
    
    return nil;
}



@end
