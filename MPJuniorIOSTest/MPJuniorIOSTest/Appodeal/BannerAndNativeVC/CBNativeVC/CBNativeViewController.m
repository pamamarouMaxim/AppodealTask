//  CBNativeViewController.m
//  MPJuniorIOSTest
//
//  Created by максим понаморёв on 7/8/18.
//  Copyright © 2018 максим понаморёв. All rights reserved.
//

#import "CBNativeViewController.h"
#import <Appodeal/Appodeal.h>
#import "UIViewController+CBAlertWithNameOfMethod.h"


//APDNativeAdLoader
@interface CBNativeViewController () <APDNativeAdPresentationDelegate,APDNativeAdLoaderDelegate>

typedef enum{
    CBRemoveProperty,
    CBSetProperty
} CBSetOrRemoveProperty;

@property (nonatomic, strong) APDNativeAdLoader* adLoader;
@property (nonatomic, strong) APDMediaView* mediaView;
@property (nonatomic, strong) APDNativeAd* nativeAd;
@end

@implementation CBNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Native";
    
}

-(void) showAlert: (NSString*) nameOfMethod{
    
    UIAlertController* alert =  [self alertFromString: nameOfMethod];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - SetRemoveProperty

-(void) setRemoveProperty : (CBSetOrRemoveProperty) state{
    if (state == CBSetProperty){
        self.bottomView.backgroundColor =  self.topView.backgroundColor = [UIColor greenColor];
        if ([self.nativeAd adChoicesView]){
            self.adChoiseView = [self.nativeAd adChoicesView];
        }
        if ([self.nativeAd iconImage]){
           
        }
        
        self.appNameLabel.text = [self.nativeAd title];
        self.callToActionLabel.text = [self.nativeAd callToActionText];
    } else if (state == CBRemoveProperty){
       
        self.iconeImageView = nil;
        self.appNameLabel.text = nil;
        self.callToActionLabel.text = nil;
        [self.mediaView removeFromSuperview];
        self.nativeAd = nil;
        self.bottomView.backgroundColor =  self.topView.backgroundColor  = [UIColor whiteColor];
    }
}


#pragma mark - Actions

-(void) showBanner:(UIBarButtonItem*) sender{
    [super touchIgnoreInApp];
    if (self.nativeAd){
        [self.view addSubview: self.mediaView];
        
        [self setRemoveProperty:CBSetProperty];
        
        self.mediaView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview: self.mediaView];
        
        NSLayoutConstraint* height = [NSLayoutConstraint constraintWithItem:self.mediaView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.4 constant:0];
        
        NSLayoutConstraint* width =[NSLayoutConstraint constraintWithItem:self.mediaView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.4 constant:0];
        
        NSLayoutConstraint* distanseY = [NSLayoutConstraint constraintWithItem:self.mediaView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        
        NSLayoutConstraint* distanseX =[NSLayoutConstraint constraintWithItem:self.mediaView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        
        [self.view addConstraints:@[height,width,distanseY,distanseX]];
    }
    
}

-(void) downloadBanner:(UIBarButtonItem*) sender{
    [super touchIgnoreInApp];
    _adLoader = [APDNativeAdLoader new];
    [_adLoader setDelegate:self];
    [_adLoader loadAdWithType:APDNativeAdTypeVideo];
}

-(void) hideBanner : (UIBarButtonItem*) sender{
    [super touchIgnoreInApp];
    if (self.mediaView){
        [self setRemoveProperty:CBRemoveProperty];
    }
  
   
}

#pragma mark - APDNativeAdLoaderDelegate

- (void)nativeAdLoader:(APDNativeAdLoader *)loader didLoadNativeAds:(NSArray <__kindof APDNativeAd *> *)nativeAds{
    if ([nativeAds count] > 0){
        
        APDNativeAd* nativeAd = [nativeAds firstObject];
        self.nativeAd = nativeAd;
        APDMediaView* mediaView = [[APDMediaView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [mediaView setNativeAd:nativeAd rootViewController:self];
        
        self.mediaView = mediaView;
        
    }
    [self showAlert:NSStringFromSelector(_cmd)];
}

- (void)nativeAdWillLogImpression:(APDNativeAd *)nativeAd{
    [self showAlert:NSStringFromSelector(_cmd)];
}

- (void)nativeAdWillLogUserInteraction:(APDNativeAd *)nativeAd{
    [self showAlert:NSStringFromSelector(_cmd)];
}

#pragma mark - APDNativeAdPresentationDelegate

- (void)nativeAdLoader:(APDNativeAdLoader *)loader didLoadNativeAd:(APDNativeAd *)nativeAd {
  
    [self showAlert:NSStringFromSelector(_cmd)];
    // нативная реклама была показана 
}

- (void)nativeAdLoader:(APDNativeAdLoader *)loader didFailToLoadWithError:(NSError *)error{
    [self showAlert:NSStringFromSelector(_cmd)];
}

#pragma mark - UITouch

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touch =  [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if ([[self.view hitTest:point withEvent:event] isEqual:self.adChoiseView]){
        [self hideBanner:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
