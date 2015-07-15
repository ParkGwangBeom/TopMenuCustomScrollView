//
//  TopMenuScrollView.m
//  TopScrollTEst
//
//  Created by yellomobile on 2015. 7. 15..
//  Copyright (c) 2015년 yellomobile. All rights reserved.
//

#import "TopMenuScrollView.h"
#import "UIImage+Stretch.h"

#define kIntroMarginW 3
#define kScrollH 30
#define kDefaultEdgeInsets UIEdgeInsetsMake(6, 12, 6, 12)

@interface TopMenuScrollView ()
@end

@implementation TopMenuScrollView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.scrollEnabled = YES;
    self.scrollsToTop = NO;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.bounces = YES;
    self.pagingEnabled = YES;
    
    self.frame = CGRectMake(0.0f, self.frame.origin.y, 320.0f, kScrollH);
}

- (id)initWithFrame:(CGRect)frame delegate:(id<TopMenuDelegate>)delegate{
    self = [super init];
    if ((self = [super initWithFrame:frame]))
    {
        self.delegate = self;
        self.topMenuDelegate = delegate;
        
        self.scrollEnabled = YES;
        self.scrollsToTop = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        
    }
    return self;
}

+ (CGFloat)widthForTagInfoTitle:(NSString *)title buttonEdgeInsets:(UIEdgeInsets)buttonEdgeInsets
{
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:10.0f]];
    return CGSizeMake(size.width + buttonEdgeInsets.left + buttonEdgeInsets.right, size.height + buttonEdgeInsets.top + buttonEdgeInsets.bottom).width;
}

- (void)calcurateWidth:(NSArray *)menuList
{
    [self calcurateWidth:menuList buttonEdgeInsets:kDefaultEdgeInsets];
}

-(void)calcurateWidth:(NSArray *)menuList buttonEdgeInsets:(UIEdgeInsets)buttonEdgeInsets{
    [self clearView];
    
    __block CGFloat buttonHeight = kScrollH;
    __block CGFloat cWidth = 0.0f;
    
    [menuList enumerateObjectsUsingBlock:^(NSDictionary *menu, NSUInteger idx, BOOL *stop) {
        NSString *tagTitle = menu[@"name"];
//        NSInteger tagID = [menu[@"id"] integerValue];
        
        CGFloat buttonWidth = [TopMenuScrollView widthForTagInfoTitle:tagTitle buttonEdgeInsets:buttonEdgeInsets];
    
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(cWidth, 0.0f, buttonWidth, buttonHeight);
        [button setTitle:tagTitle forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:10.0f];
//        [button setBackgroundImage:[UIImage imageNamed:@"tag_gray.png"].centerStretchableImage forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"tag_gray.png"].centerStretchableImage forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor colorWithRed:133.0f/255.0f green:133.0f/255.0f blue:133.0f/0xff alpha:1.0f] forState:UIControlStateNormal];
//        [button setBackgroundColor:[UIColor redColor]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = idx;
        [self addSubview:button];
        
        cWidth += buttonWidth + kIntroMarginW;
    }];

    self.contentSize = CGSizeMake(cWidth, kScrollH);
}

- (void)clearView
{
    [self.subviews enumerateObjectsUsingBlock:^(UIView *v, NSUInteger idx, BOOL *stop) {
        [v removeFromSuperview];
    }];
}

#pragma mark - Events

- (void)buttonPressed:(id)sender{
    UIButton *btn = (UIButton *)sender;
    btn.selected = YES;
    
    CGFloat btnX = btn.frame.origin.x;
    CGFloat btnRight = btnX + btn.frame.size.width;

    if(btnX > 160 && self.contentSize.width - btnRight > 160){
        [self setContentOffset:CGPointMake(btnX - 160.0f, 0.0f) animated:YES];
    }else{
        NSLog(@"메롱");
    }
    
    if([self.topMenuDelegate respondsToSelector:@selector(selectTopMenu:)]){
        [self.topMenuDelegate selectTopMenu:btn.tag];
    }
}

@end
