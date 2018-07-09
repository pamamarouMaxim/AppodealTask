//
//  CBStaticBannerViewController.m
//  MPJuniorIOSTest
//
//  Created by максим понаморёв on 7/8/18.
//  Copyright © 2018 максим понаморёв. All rights reserved.
//

#import "StackedKLCPopup.h"
#import "CBStaticBannerViewController.h"

@interface CBStaticBannerViewController () <AppodealBannerDelegate,UITextFieldDelegate>

@end

@implementation CBStaticBannerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    [Appodeal setBannerDelegate:self];
    self.placementTextField.delegate = self;
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [Appodeal hideBanner];
}

-(void) showAlert: (NSString*) nameOfMethod{
    
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutCenter);
    
    UIView*  popupView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
    popupView.backgroundColor = [UIColor greenColor];
    UILabel* textLabel = [[UILabel alloc] init];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.text = nameOfMethod;
    [popupView addSubview:textLabel];
    
    StackedKLCPopup* popup = [StackedKLCPopup popupWithContentView:popupView showType:KLCPopupShowTypeSlideInFromTop dismissType:KLCPopupDismissTypeSlideOutToTop maskType:KLCPopupMaskTypeNone dismissOnBackgroundTouch:YES dismissOnContentTouch:YES];
    [popup showWithLayout:layout duration:3];
    
    
//    UIAlertController* alert =  [super alertFromString: nameOfMethod];
//
//    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Actions

-(void) showBanner:(UIBarButtonItem*) sender{
    [super touchIgnoreInApp];
    
    [self.placementTextField resignFirstResponder];
    NSString * placement = self.placementTextField.text;
    NSLog(@"%@",placement);
    
    if ([self.navigationItem.title isEqualToString:@"Top banner"]){
        if ([placement length] > 0){
            if ([Appodeal canShowAd:AppodealShowStyleBannerTop forPlacement:placement]) {
                [Appodeal showAd:AppodealShowStyleBannerTop forPlacement:placement rootViewController:self];
            }
        } else {
            if ([Appodeal isReadyForShowWithStyle:AppodealShowStyleBannerTop]) {
                [Appodeal showAd:AppodealShowStyleBannerTop rootViewController:self];
            }
        }
    } else if ([self.navigationItem.title isEqualToString:@"Bottom banner"]){
        if ([placement length] > 0){
            if ([Appodeal canShowAd:AppodealShowStyleBannerBottom forPlacement:placement]) {
                [Appodeal showAd:AppodealShowStyleBannerBottom forPlacement:placement rootViewController:self];
            }
        } else {
            if ([Appodeal isReadyForShowWithStyle:AppodealShowStyleBannerBottom]) {
                [Appodeal showAd:AppodealShowStyleBannerBottom rootViewController:self];
            }
        }
    }
}

-(void) downloadBanner:(UIBarButtonItem*) sender{
     [super touchIgnoreInApp];
      [Appodeal cacheAd:AppodealAdTypeBanner];
}

-(void) hideBanner : (UIBarButtonItem*) sender{
     [super touchIgnoreInApp];
     [Appodeal hideBanner];
}

#pragma mark - AppodealBannerDelegate

- (void)bannerDidLoadAdIsPrecache:(BOOL)precache {
    
     [self showAlert:NSStringFromSelector(_cmd)];
}
- (void)bannerDidRefresh{
    
     [self showAlert:NSStringFromSelector(_cmd)];
}
- (void)bannerDidFailToLoadAd{
    
    [self showAlert:NSStringFromSelector(_cmd)];
}

- (void)bannerDidClick{
    
     [self showAlert:NSStringFromSelector(_cmd)];
}

- (void)bannerDidShow{
    
    [self showAlert:NSStringFromSelector(_cmd)];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.placementTextField resignFirstResponder];
    return NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
