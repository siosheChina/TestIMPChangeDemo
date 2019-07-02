//
//  SwizzleClass.m
//  TestIMPChangeDemo
//
//  Created by ios_LH on 2019/7/2.
//  Copyright © 2019 PAAT. All rights reserved.
//

#import "SwizzleClass.h"
#import <objc/runtime.h>

@implementation NSObject(Swizzle)


- (void)oneSwizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Class cls = [self class];
    Method originalMethod = class_getInstanceMethod(cls, origSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    
    IMP previousIMP = class_replaceMethod(cls,
                                          origSelector,
                                          method_getImplementation(swizzledMethod),
                                          method_getTypeEncoding(swizzledMethod));
    
    class_replaceMethod(cls,
                        newSelector,
                        previousIMP,
                        method_getTypeEncoding(originalMethod));
}

- (void)twoSwizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Class cls = [self class];
    Method originalMethod = class_getInstanceMethod(cls, origSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
 
    method_exchangeImplementations(originalMethod, swizzledMethod);
}


@end
