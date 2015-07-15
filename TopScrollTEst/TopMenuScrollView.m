//
//  TopMenuScrollView.m
//  TopScrollTEst
//
//  Created by 박광범 on 2015. 7. 15..
//  Copyright (c) 2015년 Yellomobile. All rights reserved.
//

#import "TopMenuScrollView.h"
#import "UIImage+Stretch.h"

#define kIntroMarginW 0
#define kDefaultEdgeInsets UIEdgeInsetsMake(6, 12, 6, 12)

@interface TopMenuScrollView (){
    NSInteger arrCount;
    NSMutableArray *arr_Button;
}

@end

@implementation TopMenuScrollView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self settingScroll];
}

- (id)initWithFrame:(CGRect)frame delegate:(id<TopMenuDelegate>)delegate{
    self = [super init];
    if ((self = [super initWithFrame:frame]))
    {
        self.delegate = self;
        self.topMenuDelegate = delegate;
        
        [self settingScroll];
    }
    return self;
}

-(void)settingScroll{
    self.scrollEnabled = YES;
    self.scrollsToTop = NO;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.bounces = YES;
    
    arr_Button = [[NSMutableArray alloc]init];
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
    arrCount = menuList.count;
    __block CGFloat buttonHeight = self.frame.size.height;
    __block CGFloat cWidth = 0.0f;
    
    [menuList enumerateObjectsUsingBlock:^(NSDictionary *menu, NSUInteger idx, BOOL *stop) {
        NSString *tagTitle = menu[@"name"];
        //        NSInteger tagID = [menu[@"id"] integerValue];
        
        CGFloat buttonWidth = [TopMenuScrollView widthForTagInfoTitle:tagTitle buttonEdgeInsets:buttonEdgeInsets];
        
        CGRect buttonFrame = CGRectMake(0.0f, 0.0f, buttonWidth, buttonHeight);
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(cWidth, 0.0f, buttonWidth, buttonHeight);
        [button setTitle:tagTitle forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:10.0f];
        [button setBackgroundImage:[TopMenuScrollView imageWithColor:[UIColor blackColor] RectMake:buttonFrame].centerStretchableImage forState:UIControlStateNormal];
        [button setBackgroundImage:[TopMenuScrollView imageWithColor:[UIColor redColor] RectMake:buttonFrame].centerStretchableImage forState:UIControlStateSelected];
        [button setTitleColor:[UIColor colorWithRed:133.0f/255.0f green:133.0f/255.0f blue:133.0f/0xff alpha:1.0f] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = idx;
        button.selected = (idx == 0);
        [self addSubview:button];
        
        [arr_Button addObject:button];
        
        cWidth += buttonWidth + kIntroMarginW;
    }];
    
    self.contentSize = CGSizeMake(cWidth, self.frame.size.height);
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
    
    [arr_Button enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
        obj.selected = (btn.tag == idx);
    }];
    
    CGFloat btnX = btn.frame.origin.x;
    CGFloat btnRight = btnX + btn.frame.size.width;
    CGPoint scrollPoint;
    
    /* Setting Scroll Center Point*/
    if(btnX > 160 && self.contentSize.width - btnRight > 160){
        scrollPoint = CGPointMake(btnX - 160.0f, 0.0f);
    }else if(self.contentSize.width - btnRight < 160){
        scrollPoint = CGPointMake(self.contentSize.width - self.bounds.size.width,0.0f);
    }else if(btnX < 160){
        scrollPoint = CGPointMake(0.0f,0.0f);
    }
    [self setContentOffset:scrollPoint animated:YES];
    
    /* Call Delegate */
    if([self.topMenuDelegate respondsToSelector:@selector(selectTopMenu:)]){
        [self.topMenuDelegate selectTopMenu:btn.tag];
    }
}



//필요없는 코드
+ (UIImage *)imageWithColor:(UIColor *)color RectMake:(CGRect)Cgrect
{
    CGRect rect = Cgrect;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
