//
//  ViewController.m
//  TopMenuScrollView
//
//  Created by 박광범 on 2015. 7. 15..
//  Copyright (c) 2015년 Yellomobile. All rights reserved.
//

#import "ViewController.h"

#import "TopMenuScrollView.h"

@interface ViewController ()<TopMenuDelegate, UIScrollViewDelegate>{
    NSArray *arr;
    UILabel *label;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scr_View;
@property (weak, nonatomic) IBOutlet TopMenuScrollView *TopMenuView;
@property (weak, nonatomic) IBOutlet UILabel *lb_Count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSDictionary *dicName = @{
                              @"name" : @"Call"
                              };
    NSDictionary *dicName1 = @{
                               @"name" : @"Name"
                               };
    NSDictionary *dicName2 = @{
                               @"name" : @"Frame"
                               };
    NSDictionary *dicName3 = @{
                               @"name" : @"ScrollView"
                               };
    NSDictionary *dicName4 = @{
                               @"name" : @"Delegate"
                               };
    NSDictionary *dicName5 = @{
                               @"name" : @"BringBring"
                               };
    NSDictionary *dicName6 = @{
                               @"name" : @"Coffee"
                               };
    NSDictionary *dicName7 = @{
                               @"name" : @"iPhone"
                               };
    NSDictionary *dicName8 = @{
                               @"name" : @"MacBook"
                               };
    NSDictionary *dicName9 = @{
                               @"name" : @"Wallet"
                               };
    arr = @[dicName, dicName1, dicName2, dicName3,dicName4,dicName5,dicName6,dicName7,dicName8,dicName9];
    
    self.TopMenuView.topMenuDelegate = self;
    [self.TopMenuView calcurateWidth:arr];
    
    [self.scr_View setContentSize:CGSizeMake(self.view.frame.size.width * arr.count, self.scr_View.frame.size.height)];
    
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width * idx, 200.0f, 200.0f, 20.0f)];
        label.font = [UIFont systemFontOfSize:10.0f];
        [label setBackgroundColor:[UIColor redColor]];
        label.text = arr[idx][@"name"];
        [label sizeToFit];
        [self.scr_View addSubview:label];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float f_OffsetX = self.scr_View.contentOffset.x;
    NSInteger page = f_OffsetX/self.view.frame.size.width;
    [self.TopMenuView setScrollPage:page];
}

#pragma mark - TopMenuDelegate
-(void)selectTopMenu:(NSInteger)tagId{
    [self.scr_View setContentOffset:CGPointMake(self.view.frame.size.width * tagId, 0.0f) animated:YES];
}

@end
