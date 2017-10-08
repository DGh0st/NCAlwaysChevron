@interface SBUIChevronView : UIView
@end

@interface SBNotificationCenterViewController
@property (nonatomic,readonly) SBUIChevronView* grabberView;
@property (nonatomic,readonly) UIPageControl* pageControl;
@end

SBNotificationCenterViewController *sharedInstance = nil;

%hook SBNotificationCenterViewController
-(void)loadView {
	%orig();
	sharedInstance = self;
}

-(void)_updateGrabberAndPageControlForMode:(NSUInteger)arg1 {
	%orig(arg1);
	self.pageControl.hidden = YES;
}
%end

%hook SBUIChevronView
-(void)setAlpha:(CGFloat)arg1 {
	if (sharedInstance != nil && sharedInstance.grabberView == self)
		%orig(1.0);
	else
		%orig(arg1);
}
%end