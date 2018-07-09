//
//  CBBannerViewController.h
//  MPJuniorIOSTest
//
//  Created by максим понаморёв on 7/8/18.
//  Copyright © 2018 максим понаморёв. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBBannerViewController : UIViewController          <UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *bannerTypePickview;

- (IBAction)selectBannerAction:(UIButton *)sender;


@end
