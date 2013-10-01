//
//  ViewController.m
//  Screen Blocker
//
//  Created by Dev Perfecular on 10/1/13.
//  Copyright (c) 2013 Antonio081014.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@end

@implementation ViewController

- (IBAction)switchScreenBlockOnOff:(UIButton *)sender
{
    [self drawView];
    [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(dismissScreenBlocker:) userInfo:nil repeats:NO];
}

- (void)dismissScreenBlocker:(NSTimer *)timer
{
    [self removeView];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"To (%.3f %.3f)", self.view.center.x, self.view.center.y);
    NSLog(@"To Bounds (%.3f %.3f)", self.view.bounds.size.width, self.view.bounds.size.height);
    [self startSpinning];
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"From (%.3f %.3f)", self.view.center.x, self.view.center.y);
    NSLog(@"From Bounds (%.3f %.3f)", self.view.bounds.size.width, self.view.bounds.size.height);
    [self stopSpinning];
}

- (void)startSpinning
{
    if (self.indicatorView) {
        CGRect rect = self.indicatorView.superview.bounds;
        self.indicatorView.center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
        [self.indicatorView startAnimating];
    }
}

- (void)stopSpinning
{
    if (self.indicatorView) {
        [self.indicatorView stopAnimating];
    }
}

- (void)drawView
{
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.size.height = MAX(rect.size.height, rect.size.width);
    rect.size.width = MAX(rect.size.height, rect.size.width);
    self.overlayView = [[UIView alloc] initWithFrame:rect];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:self.overlayView];
    [self.view addSubview:self.indicatorView];
    [self startSpinning];
}

- (void)removeView
{
    [self stopSpinning];
    [self.overlayView removeFromSuperview];
    self.indicatorView = nil;
}

@end
