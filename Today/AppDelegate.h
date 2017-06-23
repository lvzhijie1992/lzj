//
//  AppDelegate.h
//  Today
//
//  Created by 憧憬云天888 on 2017/6/23.
//  Copyright © 2017年 lvzhijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

