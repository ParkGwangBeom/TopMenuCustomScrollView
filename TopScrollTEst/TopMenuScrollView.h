//
//  TopMenuScrollView.h
//  TopMenuScrollView
//
//  Created by 박광범 on 2015. 7. 15..
//  Copyright (c) 2015년 Yellomobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopMenuDelegate <NSObject>

@optional
/* ScrollView Menu Button Click Delegate */
-(void)selectTopMenu:(NSInteger)tagId;
@end


@interface TopMenuScrollView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, assign) id<TopMenuDelegate> topMenuDelegate;

- (id)initWithFrame:(CGRect)frame delegate:(id<TopMenuDelegate>)delegate;
- (void)calcurateWidth:(NSArray *)menuList;
- (void)calcurateWidth:(NSArray *)menuList buttonEdgeInsets:(UIEdgeInsets)buttonEdgeInsets;
- (void)clearView;

/* Page Change Top Menu  */
-(void)setScrollPage:(NSInteger)page;

@end