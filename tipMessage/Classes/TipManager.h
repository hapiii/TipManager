//
//  TipManager.h
//  WQTips
//
//  Created by hapii on 2018/12/6.
//  Copyright © 2018年 BSK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TipManager : UILabel

+ (TipManager *)sharedManager;
- (void)_showTips:(NSString *)tip;
@end

NS_ASSUME_NONNULL_END
