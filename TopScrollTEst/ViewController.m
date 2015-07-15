//
//  ViewController.m
//  TopScrollTEst
//
//  Created by yellomobile on 2015. 7. 15..
//  Copyright (c) 2015년 yellomobile. All rights reserved.
//

#import "ViewController.h"

#import "TopMenuScrollView.h"

@interface ViewController ()<TopMenuDelegate>

@property (weak, nonatomic) IBOutlet TopMenuScrollView *TopMenuView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary *dicName = @{
                              @"name" : @"바보"
                              };
    NSDictionary *dicName1 = @{
                              @"name" : @"메롱"
                              };
    NSDictionary *dicName2 = @{
                              @"name" : @"헤헤헤헤"
                              };
    NSDictionary *dicName3 = @{
                              @"name" : @"그렇다용"
                              };
    NSDictionary *dicName4 = @{
                              @"name" : @"크크크"
                              };
    NSDictionary *dicName5 = @{
                              @"name" : @"zpzpzp"
                              };
    NSDictionary *dicName6 = @{
                              @"name" : @"헤헤헤"
                              };
    NSDictionary *dicName7 = @{
                               @"name" : @"니들이개맛을알아"
                               };
    NSDictionary *dicName8 = @{
                               @"name" : @"그놈에개맛"
                               };
    NSDictionary *dicName9 = @{
                               @"name" : @"지겹다지겨워"
                               };
    NSArray *arr = @[dicName, dicName1, dicName2, dicName3,dicName4,dicName5,dicName6,dicName7,dicName8,dicName9];
    
    self.TopMenuView.topMenuDelegate = self;
    [self.TopMenuView calcurateWidth:arr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TopMenuDelegate
-(void)selectTopMenu:(NSInteger)tagId{
    NSLog(@"%ld",tagId);
}

@end
