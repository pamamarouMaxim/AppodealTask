//
//  CBAlertCallBackViewController.m
//  MPJuniorIOSTest
//
//  Created by максим понаморёв on 7/9/18.
//  Copyright © 2018 максим понаморёв. All rights reserved.
//

#import "CBAlertCallBackViewController.h"

@interface CBAlertCallBackViewController ()

@end

@implementation CBAlertCallBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(UIAlertController*) alertFromString: (NSString*) nameOfMethod{
    
    NSString *string = nameOfMethod;
    NSRegularExpression *regexp = [NSRegularExpression
                                   regularExpressionWithPattern:@"([a-z])([A-Z])"
                                   options:0
                                   error:NULL];
    NSString *newString = [regexp
                           stringByReplacingMatchesInString:string
                           options:0
                           range:NSMakeRange(0, string.length)
                           withTemplate:@"$1 $2"];
    
    string = [newString lowercaseString] ;
    
    string = [NSString stringWithFormat:@"%@%@",[[string substringToIndex:1] uppercaseString],[string substringFromIndex:1] ];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:string
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    
    return alert;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
