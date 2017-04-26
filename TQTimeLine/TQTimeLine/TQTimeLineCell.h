//
//  TQTimeLineCell.h
//  TongQu(童趣在线)
//
//  Created by Eugene on 2017/4/25.
//  Copyright © 2017年 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQTimeLineCell : UITableViewCell
    
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
