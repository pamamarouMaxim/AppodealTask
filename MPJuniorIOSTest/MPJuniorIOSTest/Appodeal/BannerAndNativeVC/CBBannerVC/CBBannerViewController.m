//
//  CBBannerViewController.m
//  MPJuniorIOSTest
//
//  Created by максим понаморёв on 7/8/18.
//  Copyright © 2018 максим понаморёв. All rights reserved.
//

#import "CBBannerViewController.h"
#import "CBStaticBannerViewController.h"
#import "CBCustomBannerViewController.h"


@interface CBBannerViewController ()

@property (strong,nonatomic) NSArray* arrayTypeOfBanner;

@end

@implementation CBBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bannerTypePickview.delegate   = self;
    self.bannerTypePickview.dataSource = self;
    
    self.arrayTypeOfBanner = @[@"Top banner",@"Bottom banner",@"Custom banner"];

   
    // Do any additional setup after loading the view.
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self. arrayTypeOfBanner count];
}

#pragma mark - UIPickerViewDelegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [self.arrayTypeOfBanner objectAtIndex:row];
}

#pragma mark - Actions

- (IBAction)selectBannerAction:(UIButton *)sender {
    
    if ([self.bannerTypePickview selectedRowInComponent:0] <= 1){
        CBStaticBannerViewController* staticVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"CBStaticBannerViewController"] ;
        
        switch ([self.bannerTypePickview selectedRowInComponent:0]) {
            case 0:  staticVC.navigationItem.title = [self.arrayTypeOfBanner objectAtIndex:0];
                break;
            case 1:  staticVC.navigationItem.title = [self.arrayTypeOfBanner objectAtIndex:1];
                break;
            default:
                break;
        }
    
        [self.navigationController pushViewController:staticVC animated:YES];
        
    } else if (([self.bannerTypePickview selectedRowInComponent:0] == 2)){
        CBCustomBannerViewController* customVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"CBCustomBannerViewController"] ;
        
        customVC.navigationItem.title = [self.arrayTypeOfBanner objectAtIndex:2];
        
        [self.navigationController pushViewController:customVC animated:YES];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
