//
//  AppDelegate.m
//  TestIMPChangeDemo
//
//  Created by ios_LH on 2019/7/2.
//  Copyright © 2019 PAAT. All rights reserved.
//

#import "AppDelegate.h"
#import "SwizzleClass.h"


@interface Base : NSObject
@end

@implementation Base
- (void)print:(NSString*)msg
{
    NSLog(@"print-->obj %@ print say:%@", NSStringFromClass(self.class), msg);
}
- (void)hookPrint:(NSString*)msg {
    NSLog(@"hookPrin-->obj %@ print say:%@", NSStringFromClass(self.class), msg);
}
@end

@interface A : Base
@end
@implementation A
- (void)print:(NSString*)msg {
    NSLog(@"A obj print say:%@", msg);
}
@end


@interface B : Base
@end
@implementation B
@end

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //第一种实现 class_replaceMethod
//    [A oneSwizzleInstanceMethod:@selector(print:) withMethod:@selector(hookPrint:)];
//    [B oneSwizzleInstanceMethod:@selector(print:) withMethod:@selector(hookPrint:)];
    
    //第二种实现 method_exchangeImplementations
    
    [A twoSwizzleInstanceMethod:@selector(print:) withMethod:@selector(hookPrint:)];
    [B twoSwizzleInstanceMethod:@selector(print:) withMethod:@selector(hookPrint:)];
    
    //测试奔溃
//    [B oneSwizzleInstanceMethod:@selector(print:) withMethod:@selector(hookPrint2:)];

    
    [self testPrintLog];
    return YES;
}

- (void)testPrintLog{
    A* a = [A new];
    [a print:@"hello1"];
//    [a hookPrint:@"hello1.5"];

    B* b = [B new];
    [b print:@"hello2"];
    [b hookPrint:@"hello3"];

}



@end
