//
//  UIViewController+CBAlertWithNameOfMethod.h
//  MPJuniorIOSTest
//
//  Created by максим понаморёв on 7/10/18.
//  Copyright © 2018 максим понаморёв. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CBAlertWithNameOfMethod)

-(UIAlertController*) alertFromString : (NSString*) nameOfMethod;

@end
