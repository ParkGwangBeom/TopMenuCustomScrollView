//
//  TopMenuScrollView.h
//  TopScrollTEst
//
//  Created by yellomobile on 2015. 7. 15..
//  Copyright (c) 2015년 yellomobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopMenuDelegate <NSObject>

@required

@optional
-(void)selectTopMenu:(NSInteger)tagId;
@end


@interface TopMenuScrollView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, assign) id<TopMenuDelegate> topMenuDelegate;

- (id)initWithFrame:(CGRect)frame delegate:(id<TopMenuDelegate>)delegate;
- (void)calcurateWidth:(NSArray *)menuList;
- (void)calcurateWidth:(NSArray *)menuList buttonEdgeInsets:(UIEdgeInsets)buttonEdgeInsets;
- (void)clearView;

+ (CGFloat)widthForTagInfoTitle:(NSString *)title buttonEdgeInsets:(UIEdgeInsets)buttonEdgeInsets;

@end