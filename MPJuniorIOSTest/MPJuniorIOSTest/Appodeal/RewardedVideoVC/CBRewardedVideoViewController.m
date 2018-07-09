//
//  CBRewardedVideoViewController.m
//  MPJuniorIOSTest
//
//  Created by максим понаморёв on 7/8/18.
//  Copyright © 2018 максим понаморёв. All rights reserved.
//

#import "CBRewardedVideoViewController.h"
#import <Appodeal/Appodeal.h>

@interface CBRewardedVideoViewController () <AppodealRewardedVideoDelegate,UITextFieldDelegate>

@end

@implementation CBRewardedVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIBarButtonItem* showVideo = [[UIBarButtonItem alloc] initWithTitle:@"Show" style:UIBarButtonItemStylePlain target:self action:@selector(showVideo:)];
    
     UIBarButtonItem* downloadVideo = [[UIBarButtonItem alloc] initWithTitle:@"Download" style:UIBarButtonItemStylePlain target:self action:@selector(downloadVideo:)];
    
    self.navigationItem.rightBarButtonItem = downloadVideo;
    
    self.navigationItem.leftBarButtonItem = showVideo;
    
    self.navigationItem.title = @"Rewarded video";
    
    [Appodeal setRewardedVideoDelegate:self];
    self.placementTextField.delegate = self;
    
}

-(void) showAlert: (NSString*) nameOfMethod{
    
    UIAlertController* alert =  [super alertFromString: nameOfMethod];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Actions

-(void) showVideo:(UIBarButtonItem*) sender{
    [self pauseInApp];
    [self.placementTextField resignFirstResponder];
    NSString * placement = self.placementTextField.text;
    
    if ([placement length] > 0){
        if ([Appodeal canShowAd:AppodealShowStyleRewardedVideo forPlacement:placement]) {
            [Appodeal showAd:AppodealShowStyleRewardedVideo forPlacement:placement rootViewController:self];
        }
    } else {
        if ([Appodeal isReadyForShowWithStyle:AppodealShowStyleRewardedVideo]){
              [Appodeal showAd:AppodealShowStyleRewardedVideo rootViewController:self];
        }
    }
}

-(void) downloadVideo:(UIBarButtonItem*) sender{
    [self pauseInApp];
    [self.placementTextField resignFirstResponder];
    [Appodeal cacheAd:AppodealAdTypeRewardedVideo];
}

-(void) pauseInApp{
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    double delayInSeconds = 0.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    });
    
}

#pragma mark - AppodealRewardedVideoDelegate

- (void)rewardedVideoDidLoadAd {
    
    [self showAlert:NSStringFromSelector(_cmd)];
}

- (void)rewardedVideoDidFailToLoadAd {
    
    [self showAlert:NSStringFromSelector(_cmd)];
}

- (void)rewardedVideoDidPresent {
    
    [self showAlert:NSStringFromSelector(_cmd)];
}

- (void)rewardedVideoWillDismiss {
    
    [self showAlert:NSStringFromSelector(_cmd)];
}

- (void)rewardedVideoDidFinish:(NSUInteger)rewardAmount name:(NSString *)rewardName {
    
    [self showAlert:NSStringFromSelector(_cmd)];
}

#pragma mark  - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.placementTextField resignFirstResponder];
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
