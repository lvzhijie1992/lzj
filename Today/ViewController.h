//
//  ViewController.h
//  Today
//
//  Created by 憧憬云天888 on 2017/6/23.
//  Copyright © 2017年 lvzhijie. All rights reserved.
//


#import <UIKit/UIKit.h>
typedef void(^my_block)(NSString *str);

typedef enum _TTGState {
    TTGStateOK  = 0,
    TTGStateError,
    TTGStateUnknow
} TTGState;
@interface ViewController : UIViewController


@end

