//
//  UIViewController+CBAlertWithNameOfMethod.m
//  MPJuniorIOSTest
//
//  Created by максим понаморёв on 7/10/18.
//  Copyright © 2018 максим понаморёв. All rights reserved.
//

#import "UIViewController+CBAlertWithNameOfMethod.h"

@implementation UIViewController (CBAlertWithNameOfMethod)

-(UIAlertController*) alertFromString: (NSString*) nameOfMethod{
    
  
    NSString *string =  [nameOfMethod stringByReplacingOccurrencesOfString:@":" withString:@" "];
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


@end
