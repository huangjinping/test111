//
//  SKGraphicView.m
//  SKDrawingBoard
//
//  Created by youngxiansen on 15/10/10.
//  Copyright © 2015年 youngxiansen. All rights reserved.
//

#import "SKGraphicView.h"

@implementation SKGraphicView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _move = CGPointMake(0, 0);
        _start = CGPointMake(0, 0);
        _lineWidth = 2;
        _color = [UIColor redColor];
        _pathArray = [NSMutableArray array];
        
        
        //-------------重写的通知---------
       // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearBtnEvent) name:@"AginWrite" object:nil];
        
        
//        //-------------确定通知=------------
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(savePhoto) name:@"Sure" object:nil];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // 获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawPicture:context]; //画图
}

- (void)drawPicture:(CGContextRef)context {
    
    
    for (NSArray * attribute in _pathArray) {
        //将路径添加到上下文中
        CGPathRef pathRef = (__bridge CGPathRef)(attribute[0]);
        CGContextAddPath(context, pathRef);
        //设置上下文属性
        [attribute[1] setStroke];
        CGContextSetLineWidth(context, [attribute[2] floatValue]);
        //绘制线条
        CGContextDrawPath(context, kCGPathStroke);
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _path = CGPathCreateMutable(); //创建路径
    
    NSArray *attributeArry = @[(__bridge id)(_path),_color,[NSNumber numberWithFloat:_lineWidth]];
    
    [_pathArray addObject:attributeArry]; //路径及属性数组数组
    _start = [touch locationInView:self]; //起始点
    CGPathMoveToPoint(_path, NULL,_start.x, _start.y);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //    释放路径
    CGPathRelease(_path);
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _move = [touch locationInView:self];
    //将点添加到路径上
    CGPathAddLineToPoint(_path, NULL, _move.x, _move.y);
    
    [self setNeedsDisplay];
    
}

#pragma mark --点击事件--

- (void)savePhoto {
    
    if (_pathArray.count) {
        UIGraphicsBeginImageContext(self.frame.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        UIRectClip(CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
        [self.layer renderInContext:context];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIImageWriteToSavedPhotosAlbum(image, self, nil, NULL);
    }
    else{
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"alert" message:@"请您先绘制图形" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        
    }
}

-(UIImage *)getDrawingImg{
    if (_pathArray.count) {
        UIGraphicsBeginImageContext(self.frame.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        UIRectClip(CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
        [self.layer renderInContext:context];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

        return image;
    }
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请您先签字" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    return nil;
}


-(void)undoBtnEvent
{
    [_pathArray removeLastObject];
    [self setNeedsDisplay];
}

-(void)clearBtnEvent
{
    if (_pathArray.count > 0) {
        
        [_pathArray removeAllObjects];
        [self setNeedsDisplay];
    }
    
}

@end
