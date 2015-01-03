//
//  XZZViewController.m
//  Race to the Top
//
//  Created by Zac on 31/12/2014.
//  Copyright (c) 2014 1st1k. All rights reserved.
//  

#import "XZZViewController.h"
#import "XZZPathView.h"
#import "XZZMountPath.h"

@interface XZZViewController ()
@property (strong, nonatomic) IBOutlet XZZPathView *pathView;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UILabel *scoreLabel;

@end

@implementation XZZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
//    tapRecognizer.numberOfTapsRequired = 2;
//    [self.pathView addGestureRecognizer:tapRecognizer];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [self.pathView addGestureRecognizer:panRecognizer];

    self.scoreLabel = [[UILabel alloc] init];
    self.scoreLabel.frame = CGRectMake(20, 50, 280, 30);
    self.scoreLabel.textColor = [UIColor whiteColor];
    //    scoreLabel.backgroundColor = [UIColor greenColor];
    //    scoreLabel.font = [UIFont systemFontOfSize:25.0];
    self.scoreLabel.font = [UIFont boldSystemFontOfSize:25.0];
    self.scoreLabel.text = @"scoreLabel";
    [self.view addSubview:self.scoreLabel];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", XZZMAP_STARTING_SCORE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
//{
//    NSLog(@"Tapped!");
//    CGPoint tapLocation = [tapRecognizer locationInView:self.pathView];
////    CGPoint tapLocation = [tapRecognizer locationOfTouch:0 inView:self.pathView];
//    NSLog(@"Tap location is at (%f, %f)", tapLocation.x, tapLocation.y);
//}

- (void)panDetected:(UIPanGestureRecognizer *)panRecognizer
{
    CGPoint fingerLocation = [panRecognizer locationInView:self.pathView];
    NSLog(@"I'm at (%f, %f", fingerLocation.x, fingerLocation.y);

    if (panRecognizer.state == UIGestureRecognizerStateBegan && fingerLocation.y > 700) {
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", XZZMAP_STARTING_SCORE];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:XZZTIMER_INTERVAL target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    }
    else if (panRecognizer.state == UIGestureRecognizerStateChanged){
        for (UIBezierPath *path in [XZZMountPath mountainPathsForRect:self.pathView.bounds]) {
            UIBezierPath *tapTarget = [XZZMountPath tapTargetForPath:path];
            if ([tapTarget containsPoint:fingerLocation]) {
                NSLog(@"You hit the wall");
//                  [self decrementScoreByAmount:XZZMAP_SCORE_DECREMENT_AMOUNT];
                [self gameOver];
            }
        }
    }
    else if (panRecognizer.state == UIGestureRecognizerStateEnded && fingerLocation.y <= 165){
        [self.timer invalidate];
        self.timer = nil;
        UIAlertView *winAlert = [[UIAlertView alloc] initWithTitle:@"Congratulation!" message:self.scoreLabel.text  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [self.timer invalidate];
        [winAlert show];
    }
    else{
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Reminder" message:@"Please start from the buttom!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [self.timer invalidate];
        [warningAlert show];
    }
}

- (void)timerFired
{
    [self decrementScoreByAmount:XZZMAP_SCORE_DECREMENT_AMOUNT];
}

- (void)decrementScoreByAmount:(int)amount
{
    NSString *scoreText = [[self.scoreLabel.text componentsSeparatedByString:@" "] lastObject];
    int score = [scoreText intValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", score - amount];
}

- (void)gameOver
{
    UIAlertView *gameOverAlert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"You hit the wall and die" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [gameOverAlert show];
    [self.timer invalidate];
//    self.scoreLabel.text = @"Game Over";
}

@end
