//
//  main.m
//  debug-objc
//
//  Created by Closure on 2018/12/4.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
//        [[[Person alloc] init] say];
        Person *person = [[Person alloc] init];
        [person bye];
        
    }
    return 0;
}
