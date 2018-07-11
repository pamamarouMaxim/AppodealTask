//
//  CBNativeViewController.h
//  MPJuniorIOSTest
//
//  Created by максим понаморёв on 7/8/18.
//  Copyright © 2018 максим понаморёв. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBParentBannerNativeViewController.h"

@interface CBNativeViewController : CBParentBannerNativeViewController


@property (strong, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIImageView *iconeImageView;
@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;
@property (weak, nonatomic) IBOutlet UIView *adChoiseView;

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UILabel *callToActionLabel;

@end
