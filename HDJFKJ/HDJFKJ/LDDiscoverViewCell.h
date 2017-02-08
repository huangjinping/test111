//
//  LDDiscoverViewCell.h
//  HDJFKJ
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LDDiscoverViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;


@property (nonatomic,strong) LDResponseModel * model;

@end
