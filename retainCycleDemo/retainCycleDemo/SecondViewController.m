//
//  SecondViewController.m
//  retainCycleDemo
//
//  Created by 刘毅-B10037 on 2018/2/24.
//  Copyright © 2018年 halohily. All rights reserved.
//

#import "SecondViewController.h"

typedef void (^testBlock)(void);

/**
 logStr是一个字符串类型成员变量，在block中访问它时会隐式持有self，如：logStr = @"some String";
 myBlockNoSelf是一个block类型成员变量。它被self持有。demo中它的实现代码里直接访问成员变量，用以演示造成循环引用的情景。
 myBlockHasSelf是一个block类型成员变量。它被self持有。demo中它的实现代码里采用正确方式访问成员变量，用以演示如何避免循环引用。
 */
@interface SecondViewController ()
{
    NSString *logStr;
    testBlock myBlockNoSelf;
    testBlock myBlockHasSelf;
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    输出self的引用计数
    [self logRetainCount];
    
    //    初始化测试block
    [self setMyBlock];
    
    [self logRetainCount];
    // Do any additional setup after loading the view.
}

- (void)setMyBlock
{
    
    //    这个block被self持有。在block中直接访问成员变量，隐式持有self，造成了循环引用
    myBlockNoSelf = ^() {
        logStr = @"now set logStr first";
    };
    
    //    此block采用正确方式访问成员变量，避免循环引用
    __weak typeof(self) weakSelf = self;
    myBlockHasSelf = ^() {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf->logStr = @"now set logStr again";
        //        演示：在被self持有的block内调用其他方法
        [strongSelf littleLog];
    };
    
    //    此block不是成员变量，没有被self持有。因此可直接访问成员变量，不会造成循环引用
    void (^anotherBlock)(void) = ^() {
        logStr = @"little log set logStr";
        NSLog(@"%@",logStr);
    };
    
    myBlockNoSelf();
    myBlockHasSelf();
    anotherBlock();
}

/**
 使用kvc访问引用计数
 */
- (void)logRetainCount
{
    NSLog(@"self's retain count: %@", [self valueForKey:@"retainCount"]);
}

- (void)littleLog
{
    NSLog(@"little log");
}


/**
 若未造成内存泄漏，则dealloc方法正确执行，进行log提示
 */
- (void)dealloc
{
    NSLog(@"dealloc invoked");
}

@end

