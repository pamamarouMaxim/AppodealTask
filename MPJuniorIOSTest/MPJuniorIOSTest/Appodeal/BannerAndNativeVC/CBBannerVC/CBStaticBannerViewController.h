//
//  CBStaticBannerViewController.h
//  MPJuniorIOSTest
//
//  Created by максим понаморёв on 7/8/18.
//  Copyright © 2018 максим понаморёв. All rights reserved.
//

#import "CBParentBannerNativeViewController.h"

typedef enum {
    CBBannerTop,
    CBBannerButtom
} CBTypeOfBanner;

@interface CBStaticBannerViewController : CBParentBannerNativeViewController

@property(assign,nonatomic)  CBTypeOfBanner typeOfBanner;

@property (weak, nonatomic) IBOutlet UITextField *placementTextField;

@end
