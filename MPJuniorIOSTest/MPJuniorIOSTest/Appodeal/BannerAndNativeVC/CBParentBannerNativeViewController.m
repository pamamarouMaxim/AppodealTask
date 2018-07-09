//
//  CBParentBannerNativeViewController.m
//  MPJuniorIOSTest
//
//  Created by максим понаморёв on 7/8/18.
//  Copyright © 2018 максим понаморёв. All rights reserved.
//

#import "CBParentBannerNativeViewController.h"

@interface CBParentBannerNativeViewController ()

@end

@implementation CBParentBannerNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem* downloadBanner = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(downloadBanner:)];
    
      UIBarButtonItem* showBanner = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(showBanner:)];
    
      UIBarButtonItem* hideBanner = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(hideBanner:)];
    
    self.navigationItem.rightBarButtonItems = @[hideBanner,showBanner, downloadBanner];
}

#pragma mark Actions

-(void) showBanner:(UIBarButtonItem*) sender{
 
}

-(void) downloadBanner:(UIBarButtonItem*) sender{
   
}

-(void) hideBanner : (UIBarButtonItem*) sender{
   
}

-(void) touchIgnoreInApp{
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    double delayInSeconds = 0.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    });
    
}

@end
