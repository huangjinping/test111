//
//  LDTitleButton.m
//  LotteryTicket
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDTitleButton.h"

@interface LDTitleButton ()
@property(nonatomic,strong) UIFont * titleFont;

@end


@implementation LDTitleButton
/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame ]) {
        
        [self setUp];
        
    }
    return self;

}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [self setUp];
    }
    return self;
}

- (void)setUp{
    
    self.titleFont = [UIFont systemFontOfSize:16];
    
    self.titleLabel.font = self.titleFont;
    
    self.imageView.contentMode = UIViewContentModeCenter;

}


//自定义Button的原因是,Button默认是图片在左,lable在右,需求是将Button的lable放在左边,图片放在右边,就是交换imageView和Lable的位置,方便起见,lable和imageView的高度都设置为button的高度.

//自定义titleLable的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat x = 0;
    CGFloat y = 0;
    
    CGFloat w = [self sizeWithText:self.currentTitle font:self.titleFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    
    CGFloat h = contentRect.size.height;
    
    return CGRectMake(x, y, w, h);
}

//自定义imageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat w = 30;

    CGFloat x = contentRect.size.width - w;
    CGFloat y = 0;
    CGFloat h = contentRect.size.height;

    return CGRectMake(x, y, w, h);
}


@end
