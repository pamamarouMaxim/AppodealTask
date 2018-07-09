//
//  StackedKLCPopup.m
//  KLCPopupWork
//
//  Created by Andrew Koryagin on 1/14/17.
//  Copyright © 2017 Curve. All rights reserved.
//

#import "StackedKLCPopup.h"
#import <Foundation/NSObjCRuntime.h>
#import <UIKit/UIKit.h>

static NSInteger const kAnimationOptionCurveIOS7 = (7 << 16);
static CGFloat const verticalStackMargin = 25.0;

@interface StackedKLCPopup ()
    @property (strong, nonatomic) NSMutableArray *popUpStack;
@end


@implementation StackedKLCPopup


#pragma mark Class construction
+ (instancetype) popupWithContentView:(UIView*)contentView
                                  showType:(KLCPopupShowType)showType
                               dismissType:(KLCPopupDismissType)dismissType
                                  maskType:(KLCPopupMaskType)maskType
                  dismissOnBackgroundTouch:(BOOL)shouldDismissOnBackgroundTouch
                     dismissOnContentTouch:(BOOL)shouldDismissOnContentTouch {
    StackedKLCPopup * popup = [[[self class] alloc] init];
    popup.contentView = contentView;
    popup.showType = showType;
    popup.dismissType = dismissType;
    popup.maskType = maskType;
    popup.shouldDismissOnBackgroundTouch = shouldDismissOnBackgroundTouch;
    popup.shouldDismissOnContentTouch = shouldDismissOnContentTouch;

    return popup;

    
}

#pragma mark Parent methods
- (void) willStartShowing {
    self.popUpStack = [[NSMutableArray alloc] init];
   
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        if (window.windowLevel == UIWindowLevelNormal) {
            [self getPresentedPopUps:[window subviews] includingDismissing:NO];
            CGRect lastPopUpFrame = [self getContentViewForPopUp:[self.popUpStack lastObject]].frame;
            self.verticalPopUpSpacing = verticalStackMargin + lastPopUpFrame.origin.y + lastPopUpFrame.size.height;
            break;
        }
    }

}
- (void)willStartDismissing {
    self.popUpStack = [[NSMutableArray alloc] init];
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        if (window.windowLevel == UIWindowLevelNormal) {
            [self getPresentedPopUps:[window subviews] includingDismissing:YES];
        }
    }
    [self moveUpPopUpContainersBelow:(UIView *)self];
}

-(void) showWithLayout:(KLCPopupLayout)layout {
    [super showWithLayout:layout];
}

#pragma mark Private


-(void) getPresentedPopUps : (NSArray *) views includingDismissing : (BOOL) includeDismissing {
    for (UIView *subview in views) {
        if ([subview isKindOfClass:[StackedKLCPopup class]]) {
            StackedKLCPopup * popUPView =  (StackedKLCPopup *)subview;
            if((popUPView.isBeingDismissed && includeDismissing) || !popUPView.isBeingDismissed)  {
                    [self.popUpStack addObject:subview];
            }
        } else {
            [self getPresentedPopUps:subview.subviews includingDismissing:includeDismissing];
        }
    }
}

-(UIView *) getContentViewForPopUp : (UIView *) popUpView {
    
    NSArray *subviews = [popUpView subviews];
    
    if([subviews count] >= 2) {
        //return the subview of popUp background view that has to be content view.
        return [[popUpView subviews] objectAtIndex:1];
    } else {
        return nil;
    }
    
}

-(void) moveUpPopUpContainersBelow : (UIView *) popUpView {
    
    CGRect popUpFrame = [self getContentViewForPopUp:popUpView].frame;
    NSInteger popUpIndex = 0;
    NSInteger stackCount = [self.popUpStack count];
    
    for (NSInteger i = 0; i < stackCount; i++) {
        if([self.popUpStack objectAtIndex:i] == self)
            popUpIndex = i;
    }
    
    if(popUpIndex < (stackCount - 1)) {
        for (NSInteger i = popUpIndex + 1; i < stackCount; i++) {
            StackedKLCPopup *movedPopUp = [self.popUpStack objectAtIndex:i];
            UIView *movedContainer = [self getContentViewForPopUp:(UIView *)movedPopUp];
            CGRect finalFrame = movedContainer.frame;
            finalFrame.origin.y = finalFrame.origin.y - popUpFrame.size.height - verticalStackMargin;
            [self shiftView:movedContainer ToPosition:finalFrame];
        }
    }
}

-(void) shiftView : (UIView *) view ToPosition : (CGRect) frame {
    [UIView animateWithDuration:0.30
                          delay:0
                        options:kAnimationOptionCurveIOS7
                     animations:^{
                         CGRect finalFrame = frame;
                         view.frame = finalFrame;
                     }
                     completion:nil];
}

@end
