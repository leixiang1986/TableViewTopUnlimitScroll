//
//  CustomTableView.m
//  LXCalendar
//
//  Created by 雷祥 on 2017/5/10.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "CustomTableView.h"

@interface CustomTableView ()
@property (nonatomic,assign) CGSize oldContentSize;
@property (nonatomic,assign) CGPoint oldContentOffset;
@end

@implementation CustomTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        _oldContentOffset = CGPointMake(0, -MAXFLOAT);

    }

    return self;
}


/**
 * 实现无线数据添加滚动
 */
- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.oldContentSize.height != self.contentSize.height && self.contentOffset.y < _oldContentOffset.y) {
        CGFloat height = ABS(self.oldContentSize.height - self.contentSize.height);
        [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y + height)];
    }

    //向下滑动，加载数据
    if (self.contentOffset.y < _oldContentOffset.y && self.contentOffset.y < 10) {
        NSLog(@"刷新前:contentSize:%@---old:%@",NSStringFromCGSize(self.contentSize),NSStringFromCGSize(self.oldContentSize));
        NSLog(@"刷新前:layoutSubviews中conetntOffset:%@---old:%@",NSStringFromCGPoint(self.contentOffset),NSStringFromCGPoint(_oldContentOffset));
        if (self.layoutSubViewsBlock) {
            self.layoutSubViewsBlock(NO,self.contentOffset.y);
        }
        NSLog(@"刷新后:contentSize:%@---old:%@",NSStringFromCGSize(self.contentSize),NSStringFromCGSize(self.oldContentSize));
        NSLog(@"刷新后:layoutSubviews中conetntOffset:%@---old:%@",NSStringFromCGPoint(self.contentOffset),NSStringFromCGPoint(_oldContentOffset));
        if (self.oldContentSize.height != self.contentSize.height) {
            CGFloat height = ABS(self.oldContentSize.height - self.contentSize.height);
            [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y + height)];
        }

    }
    else {


    }

    self.oldContentSize = self.contentSize;
    _oldContentOffset = self.contentOffset;
}

- (void)setOldContentSize:(CGSize)oldContentSize {
    if (oldContentSize.height != _oldContentSize.height) {
        NSLog(@"==");
    }

    _oldContentSize = oldContentSize;
    NSLog(@"set方法---old:%@",NSStringFromCGSize(self.oldContentSize));
}


@end
