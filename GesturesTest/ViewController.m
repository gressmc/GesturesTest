//
//  ViewController.m
//  GesturesTest
//
//  Created by gressmc on 27/11/14.
//  Copyright (c) 2014 gressmc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>{
    CGPoint touchPoint;
    UIPanGestureRecognizer* panGesture;
}

@property(weak,nonatomic)UIImageView* viewSquare;

@property(assign,nonatomic)CGFloat testScale;
@property(assign,nonatomic)CGFloat testRotation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handeTap:)];
    
    // 2 касания
    //tapGesture.numberOfTouchesRequired = 2;

    [self.view addGestureRecognizer:tapGesture];

    UITapGestureRecognizer* doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handeDoubleTap:)];
    
    [self.view addGestureRecognizer:doubleTapGesture];

    //Двойной тап
    doubleTapGesture.numberOfTapsRequired = 2;
    
    // tapGesture тап будет ждать возможного doubleTapGesture
    //[tapGesture requireGestureRecognizerToFail:doubleTapGesture];
    */
    
    // Создаем тестовую вьюшку квадрата которая будет менять цвет при нажатии и вращаться при двойном нажатии
    UIImageView* view = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds)-1872,
                                                            CGRectGetMidY(self.view.bounds)-1872,
                                                            3744, 3744)];
    view.image = [UIImage imageNamed:@"1.jpg"];
    
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                             UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    self.viewSquare = view;
    
    /*
    // Реализуем "Щипок"
    UIPinchGestureRecognizer* pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handePinchGesture:)];
    pinchGesture.delegate = self;
    [self.view addGestureRecognizer:pinchGesture];
    
    //Реализуем "Вращение"
    UIRotationGestureRecognizer* rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                                action:@selector(handeRotationGesture:)];
    rotationGesture.delegate = self;
    
    [self.view addGestureRecognizer:rotationGesture];
    
    //Реализуем "Свайп"
    UISwipeGestureRecognizer* swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                                action:@selector(handeSwipeGesture:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGesture];
    */
    
    //Реализуем движение мышкой "Панарамирование"
    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                         action:@selector(handePanGesture:)];
    [self.view addGestureRecognizer:panGesture];
    
    /*
    //Реализуем Долгое нажатие
    UILongPressGestureRecognizer* longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                   action:@selector(handeLongPressGesture:)];
    [self.view addGestureRecognizer:longPressGesture];
    
    //Реализуем "?????"
    UIScreenEdgePanGestureRecognizer* screenEdgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                                                                               action:@selector(handeScreenEdgePanGesture:)];
    [self.view addGestureRecognizer:screenEdgePanGesture];
    
   // [panGesture requireGestureRecognizerToFail:swipeGesture];
   */
}

- (UIColor*) randomColor {
    CGFloat r = (CGFloat)(arc4random() % 256) / 255.f;
    CGFloat g = (CGFloat)(arc4random() % 256) / 255.f;
    CGFloat b = (CGFloat)(arc4random() % 256) / 255.f;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

/*
#pragma mark - Gestures -

-(void)handeTap:(UITapGestureRecognizer*) tapGesture{
    NSLog(@"%@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    self.viewSquare.backgroundColor = [self randomColor];
}

-(void)handeDoubleTap:(UITapGestureRecognizer*) tapGesture{
    NSLog(@"handeDoubleTap %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    if (tapGesture.state == UIGestureRecognizerStateBegan) {
        self.testRotation = 0.f;
    }
    
    CGAffineTransform rotation1 = CGAffineTransformMakeRotation(M_PI/2 + self.testRotation);
    CGAffineTransform scale = CGAffineTransformMakeScale(self.testScale, self.testScale);
    CGAffineTransform transform = CGAffineTransformConcat(rotation1, scale);
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.viewSquare.transform = transform;
                     }
                     completion:^(BOOL finished) {
                         self.testRotation += M_PI/2;
                     }];
}

-(void)handePinchGesture:(UIPinchGestureRecognizer*) tapGesture{
    NSLog(@"handePinchGesture %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    if (tapGesture.state == UIGestureRecognizerStateBegan) {
        self.testScale = 1.f;
    }
    CGFloat newScale = 1.f + tapGesture.scale - self.testScale;
    
    CGAffineTransform currentTransform = self.viewSquare.transform;

    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, newScale, newScale);
    self.viewSquare.transform = newTransform;
    
    self.testScale = tapGesture.scale;
}

-(void)handeRotationGesture:(UIRotationGestureRecognizer*) tapGesture{
    NSLog(@"handeRotationGesture %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    if (tapGesture.state == UIGestureRecognizerStateBegan) {
        self.testRotation = 0.f;
    }
    
    CGFloat newRotation = tapGesture.rotation - self.testRotation;
    
    CGAffineTransform currentTransform = self.viewSquare.transform;
    self.viewSquare.transform = CGAffineTransformRotate(currentTransform, newRotation);
    
    self.testRotation = tapGesture.rotation;
}

-(void)handeSwipeGesture:(UISwipeGestureRecognizer*) tapGesture{
    NSLog(@"handeSwipeGesture %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAutoreverse
                     animations:^{
                         self.viewSquare.transform = CGAffineTransformMakeTranslation(150, 0);
                     }
                     completion:^(BOOL finished) {
                         self.viewSquare.transform = CGAffineTransformMakeTranslation(0, 0);
                     }];
    
}
*/



-(void)handePanGesture:(UIPanGestureRecognizer*) tapGesture{
   NSLog(@"handePanGesture %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    CGPoint pointOnView = [tapGesture locationInView:self.view];
    if([(UIPanGestureRecognizer*)tapGesture state] == UIGestureRecognizerStateBegan) {
        NSLog(@"UIGestureRecognizerStateBegan");
        [self pointOnView:tapGesture];
    }
    if([(UIPanGestureRecognizer*)tapGesture state] == UIGestureRecognizerStateChanged) {
        NSLog(@"UIGestureRecognizerStateChanged");
        self.viewSquare.center = CGPointMake(pointOnView.x + touchPoint.x, pointOnView.y + touchPoint.y);
    }
   
}

-(void) pointOnView:(UIPanGestureRecognizer*) tapGesture{
    
    CGPoint pointOnView = [tapGesture locationInView:self.viewSquare];
    
    touchPoint = CGPointMake(CGRectGetMidX(self.viewSquare.bounds)-pointOnView.x, CGRectGetMidY(self.viewSquare.bounds)-pointOnView.y);
}

/*
-(void)handeLongPressGesture:(UILongPressGestureRecognizer*) tapGesture{
    //NSLog(@"handeLongPressGesture %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
}

-(void)handeScreenEdgePanGesture:(UIScreenEdgePanGestureRecognizer*) tapGesture{
    NSLog(@"handeScreenEdgePanGesture %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
}

#pragma mark - UIGestureRecognizerDelegate -

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    
    return YES;
}
*/
@end
