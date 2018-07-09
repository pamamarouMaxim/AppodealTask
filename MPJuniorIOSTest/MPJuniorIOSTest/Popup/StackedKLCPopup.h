//
//  StackedKLCPopup.h
//  KLCPopupWork
//
//  Created by Andrew Koryagin on 1/14/17.
//  Copyright © 2017 Curve. All rights reserved.
//

#import "KLCPopup.h"

@interface StackedKLCPopup : KLCPopup

+ (instancetype ) popupWithContentView:(UIView*)contentView
                                  showType:(KLCPopupShowType)showType
                               dismissType:(KLCPopupDismissType)dismissType
                                  maskType:(KLCPopupMaskType)maskType
                  dismissOnBackgroundTouch:(BOOL)shouldDismissOnBackgroundTouch
                     dismissOnContentTouch:(BOOL)shouldDismissOnContentTouch;

-(void) showWithLayout:(KLCPopupLayout)layout;

@end
