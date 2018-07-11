//
//  CBCustomBannerViewController.m
//  MPJuniorIOSTest
//
//  Created by максим понаморёв on 7/8/18.
//  Copyright © 2018 максим понаморёв. All rights reserved.
//

#import "CBCustomBannerViewController.h"

#define isTablet UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

@interface CBCustomBannerViewController () <AppodealBannerViewDelegate>

@property(strong,nonatomic) AppodealBannerView* bannerView;

@end

@implementation CBCustomBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void) showAlert: (NSString*) nameOfMethod{
    
    UIAlertController* alert =  [self alertFromString: nameOfMethod];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Actions

-(void) showBanner:(UIBarButtonItem*) sender{
    
    [super touchIgnoreInApp];
    [self.bannerView loadAd];
    
}

-(void) downloadBanner:(UIBarButtonItem*) sender{
    
    [super touchIgnoreInApp];
    CGSize bannerSize = kAPDAdSize320x50;
    if (isTablet) {
        bannerSize = kAPDAdSize728x90;
    }
    
    self.bannerView = [[AppodealBannerView alloc] initWithSize:bannerSize rootViewController:self];
    self.bannerView.delegate = self;
    
    [self.bannerView setBackgroundVisible:YES];
    [self.bannerView setUsesSmartSizing:YES];
    
    [self.bannerView setAdSize:bannerSize];
    
    self.bannerView.center = CGPointMake(self.view.center.x, self.view.center.y);
    
}

-(void) hideBanner : (UIBarButtonItem*) sender{
    
    [super touchIgnoreInApp];

    [self.bannerView removeFromSuperview];
}

#pragma mark - AppodealBannerViewDelegate

- (void)bannerViewDidLoadAd:(APDBannerView *)bannerView {
   [self.view addSubview:self.bannerView];
   [self showAlert:NSStringFromSelector(_cmd)];
}

- (void)bannerViewDidInteract:(APDBannerView *)bannerView {
   
     [self showAlert:NSStringFromSelector(_cmd)];
}

- (void)bannerView:(APDBannerView *)bannerView didFailToLoadAdWithError:(NSError *)error {
   
    [self showAlert:NSStringFromSelector(_cmd)];
}

- (void)bannerViewDidRefresh:(APDBannerView *)bannerView {
   
   [self showAlert:NSStringFromSelector(_cmd)];
}

- (void)bannerViewDidShow:(APDBannerView *)bannerView{
    
    [self showAlert:NSStringFromSelector(_cmd)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
