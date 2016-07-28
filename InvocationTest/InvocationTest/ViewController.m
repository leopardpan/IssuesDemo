//
//  ViewController.m
//  InvocationTest
//
//  Created by baixinpan on 16/7/26.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

#import "ViewController.h"
#import "TestObjc.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)add:(UIButton *)sender {

    TestObjc *obj = [[TestObjc alloc] init];
    obj.major = [NSNumber numberWithInt:10];
    obj.minor = [NSNumber numberWithInt:20];
    [self parseObjc:obj];
    
    id test = [[NSUserDefaults standardUserDefaults] objectForKey:@"test"];
    NSLog(@"test = %@",test);

}


- (void)parseObjc:(TestObjc *)obj {

    Class Objc = NSClassFromString(@"TestObjc");
    if (Objc) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        //  get major
        NSMethodSignature *sigMajor = [Objc instanceMethodSignatureForSelector:@selector(major)];
        NSInvocation *invoMajor = [NSInvocation invocationWithMethodSignature:sigMajor];
        [invoMajor setTarget:obj];
        [invoMajor setSelector:@selector(major)];
        [invoMajor invoke];
        const char *majorReturnType = sigMajor.methodReturnType;
        
        id objcMajor;
        if( !strcmp(majorReturnType, @encode(id)) ) {
            [invoMajor getReturnValue:&objcMajor];
        }

        
//        void *temp1 = NULL;
//        [invoMajor getReturnValue:&temp1];
//        id objcMajor  = (__bridge id)temp1;
//
        
        [dic setObject:objcMajor forKey:@"major"];
        
        //  get minor
        NSMethodSignature *sigMinor = [Objc instanceMethodSignatureForSelector:@selector(minor)];
        NSInvocation *invoMinor = [NSInvocation invocationWithMethodSignature:sigMinor];
        [invoMinor setTarget:obj];
        [invoMinor setSelector:@selector(minor)];
        [invoMinor invoke];
        const char *minorReturnType = sigMinor.methodReturnType;
        
        id objcMinor;
        
        if( !strcmp(minorReturnType, @encode(id)) ) {
            [invoMinor getReturnValue:&objcMinor];
        }
        
//        void *temp2 = NULL;
//        [objcMinor getReturnValue:&temp2];
//        id objcMinor  = (__bridge id)temp2;
//        

        [dic setObject:objcMinor forKey:@"minor"];
        
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"test"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
