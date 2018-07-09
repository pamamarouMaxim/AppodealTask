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
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *height;

@end

@implementation CBCustomBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize bannerSize = kAPDAdSize320x50;
    if (isTablet) {
        bannerSize = kAPDAdSize728x90;
    }
    
    self.bannerView = [[AppodealBannerView alloc] initWithSize:bannerSize rootViewController:self];
    self.bannerView.delegate = self;
    [self.view addSubview:self.bannerView];
    
    
    [self.bannerView setBackgroundVisible:YES];
    [self.bannerView setUsesSmartSizing:YES];
    
    [self.bannerView setAdSize:bannerSize];
//    self.height.constant = bannerSize.height;
    
    self.bannerView.center = CGPointMake(self.view.center.x, self.view.center.y);
    
    [self.bannerView loadAd];
}

-(void) showAlert: (NSString*) nameOfMethod{
    
    UIAlertController* alert =  [super alertFromString: nameOfMethod];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Actions

-(void) showBanner:(UIBarButtonItem*) sender{
    [super touchIgnoreInApp];
    
    [self.view addSubview:self.bannerView];
    [self.bannerView loadAd];
   // [Appodeal showAd:(AppodealShowStyle) rootViewController:<#(UIViewController *)#>]
}

-(void) downloadBanner:(UIBarButtonItem*) sender{
    [super touchIgnoreInApp];
    [Appodeal hideBanner];
}

-(void) hideBanner : (UIBarButtonItem*) sender{
    [super touchIgnoreInApp];
     [Appodeal hideBanner];
}

#pragma mark - AppodealBannerViewDelegate

- (void)bannerViewDidLoadAd:(APDBannerView *)bannerView {
  
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
