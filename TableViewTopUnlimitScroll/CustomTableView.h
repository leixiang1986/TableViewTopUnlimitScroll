//
//  CustomTableView.h
//  LXCalendar
//
//  Created by 雷祥 on 2017/5/10.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableView : UITableView
@property (nonatomic,copy) void(^layoutSubViewsBlock)(BOOL isUp, CGFloat contentOffsetY);
@end
