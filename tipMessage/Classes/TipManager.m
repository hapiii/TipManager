//
//  TipManager.m
//  WQTips
//
//  Created by hapii on 2018/12/6.
//  Copyright © 2018年 BSK. All rights reserved.
//

#import "TipManager.h"
#define  screen_height [UIScreen mainScreen].bounds.size.height
#define  screen_width [UIScreen mainScreen].bounds.size.width


@interface TipManager ()

@property(nonatomic,strong)UILabel *tipLab;

@end
@implementation TipManager

static TipManager *_instance = nil;

// 单例
+ (TipManager *)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [[self alloc] init];
            [_instance configLabel];
        }
    });
    
    return _instance;
}

-(void)configLabel{
    
    self.tipLab = [[UILabel alloc] initWithFrame:CGRectMake(screen_width/4,screen_height*2/3, screen_width/2,0.1)];
    self.tipLab.center = CGPointMake(screen_width/2, screen_height*2/3);
    self.tipLab.numberOfLines = 0;
    self.tipLab.textAlignment = NSTextAlignmentCenter;
    self.tipLab.font = [UIFont systemFontOfSize:14];
    self.tipLab.textColor = [UIColor whiteColor];
    self.tipLab.alpha = .5;
    self.tipLab.backgroundColor = [UIColor blackColor];
    self.tipLab.layer.cornerRadius = 4;
    self.tipLab.clipsToBounds = YES;
    
}

- (void)_showTips:(NSString *)tip{
    
    
    self.tipLab.alpha = 0;
    
    @synchronized (self) {
        [UIView animateWithDuration:0.2 animations:^{
            [[UIApplication sharedApplication].keyWindow addSubview:self.tipLab];
            self.tipLab.alpha = 1;
            self.tipLab.text = tip;
            [self.tipLab sizeToFit];
            
            
            
        } completion:^(BOOL finished) {
            
            if (self.tipLab) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self _hiddenTip];
                });
            }else{
                NSLog(@"已被移除");
            }
            
        }];
    }
    

}

-(void)_hiddenTip{
    NSLog(@"%p延时清处",self.tipLab);
    [UIView animateWithDuration:0.2 animations:^{
        self.tipLab.alpha = 0;
        self.tipLab.frame = CGRectMake(screen_width/4,screen_height*2/3, screen_width/2,0.1);
    } completion:^(BOOL finished) {
        [self.tipLab removeFromSuperview];
        //self.tipLab = nil;
    }];
}


@end
