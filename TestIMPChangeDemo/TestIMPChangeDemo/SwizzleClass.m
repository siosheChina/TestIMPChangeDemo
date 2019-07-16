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


+ (void)oneSwizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Class cls = [self class];
    Method originalMethod = class_getInstanceMethod(cls, origSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    
    
    BOOL success = class_addMethod(cls, origSelector, method_getImplementation(swizzledMethod),
                                   method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(cls, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        
        IMP previousIMP = class_replaceMethod(cls,
                                              origSelector,
                                              method_getImplementation(swizzledMethod),
                                              method_getTypeEncoding(swizzledMethod));
        
        class_replaceMethod(cls,
                            newSelector,
                            previousIMP,
                            method_getTypeEncoding(originalMethod));
    }

}

+ (void)twoSwizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Class cls = [self class];
    Method originalMethod = class_getInstanceMethod(cls, origSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
 
    method_exchangeImplementations(originalMethod, swizzledMethod);
}


+ (void)fourSwizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Class cls = [self class];
    Method originalMethod = class_getInstanceMethod(cls, origSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    
    //这里添加了class_addMethod
    BOOL success = class_addMethod(cls, origSelector, method_getImplementation(swizzledMethod),
                                   method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(cls, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}



@end
