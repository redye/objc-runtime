//
//  Person.m
//  debug-objc
//
//  Created by redye.hu on 2019/4/11.
//

#import "Person.h"
#import <objc/runtime.h>
#import "Proxy.h"

@implementation Person

+ (void)load {
    NSLog(@"Person load");
}

- (void)say {
    NSLog(@"person say");
}

- (void)sayBye {
    NSLog(@"say bye-bye");
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(bye)) {
        SEL newSel = NSSelectorFromString(@"sayBye");
        Method method = class_getInstanceMethod(self, newSel);
        IMP imp = method_getImplementation(method);
        const char *type = method_getTypeEncoding(method);
        class_addMethod(self, sel, imp, type);
        return NO;
    }
    
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
//    Proxy *proxy = [[Proxy alloc] init];
//    if ([@"bye" isEqualToString:NSStringFromSelector(aSelector)]) {
//        return proxy;
//    }
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([@"bye" isEqualToString:NSStringFromSelector(aSelector)]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([@"bye" isEqualToString:NSStringFromSelector(anInvocation.selector)]) {
        Proxy *proxy = [[Proxy alloc] init];
        [anInvocation invokeWithTarget:proxy];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

@end
