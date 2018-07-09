//
//  CBNativeViewController.m
//  MPJuniorIOSTest
//
//  Created by максим понаморёв on 7/8/18.
//  Copyright © 2018 максим понаморёв. All rights reserved.
//

#import "CBNativeViewController.h"
#import <Appodeal/Appodeal.h>


//APDNativeAdLoader
@interface CBNativeViewController () <APDNativeAdPresentationDelegate,APDNativeAdLoaderDelegate>

@property (nonatomic, strong) APDNativeAdLoader* adLoader;
@property (nonatomic, strong) APDMediaView* mediaView;
@end

@implementation CBNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Native";
    
    
    _adLoader = [APDNativeAdLoader new];
    [_adLoader loadAdWithType:APDNativeAdTypeVideo];
    [_adLoader setDelegate:self];

    // Do any additional setup after loading the view.
}

#pragma mark - Actions

-(void) showBanner:(UIBarButtonItem*) sender{
    [super touchIgnoreInApp];
}

-(void) downloadBanner:(UIBarButtonItem*) sender{
    [super touchIgnoreInApp];
}

-(void) hideBanner : (UIBarButtonItem*) sender{
    [super touchIgnoreInApp];
    [self.mediaView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - APDNativeAdLoaderDelegate

- (void)nativeAdLoader:(APDNativeAdLoader *)loader didLoadNativeAds:(NSArray <__kindof APDNativeAd *> *)nativeAds{
    APDNativeAd* nativeAd = [nativeAds firstObject];
    
    APDMediaView* mediaView = [[APDMediaView alloc] initWithFrame:CGRectMake(100, 110, 200, 200)];
    [mediaView setNativeAd:nativeAd rootViewController:self];
    [self.view addSubview: mediaView];
    self.mediaView = mediaView;
}


- (void)nativeAdLoader:(APDNativeAdLoader *)loader didLoadNativeAd:(APDNativeAd *)nativeAd {
}

- (void)nativeAdLoader:(APDNativeAdLoader *)loader didFailToLoadWithError:(NSError *)error{
    
}

#pragma mark - APDNativeAdPresentationDelegate

- (void)nativeAdWillLogImpression:(APDNativeAd *)nativeAd{
    
}

- (void)nativeAdWillLogUserInteraction:(APDNativeAd *)nativeAd{
    
}



@end
