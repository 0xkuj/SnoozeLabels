#import "Tweak.h"

static MTAlarmManager *alarmManager;

%hook NCSnoozeAlarmNotificationStaticContentProvider

%property (nonatomic, retain) NSString *snoozeCustomTitle;

- (id)initWithNotificationRequest:(NCNotificationRequest *)arg1 viewController:(id)arg2 {
	NSString *alarmId = [%c(NCSnoozeAlarmNotificationStaticContentProvider) getIdFromNotificationIdentifier:arg1.notificationIdentifier];
	[self initAlarmManagerIfNeeeded];
	if (alarmManager != nil) {
		self.snoozeCustomTitle = ((MTMutableAlarm *)[alarmManager alarmWithIDString:alarmId]).title;
	}
	return %orig;
}

%new 
- (void)initAlarmManagerIfNeeeded {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		alarmManager = [[%c(SBScheduledAlarmObserver) sharedInstance] valueForKey:@"_alarmManager"];
	});
}

%new
+ (NSString *)getIdFromNotificationIdentifier:(NSString *)notificationIdentifier {
	NSRange prefixRange = [notificationIdentifier rangeOfString:@"MTSnoozeCountdown"];
	NSRange suffixRange = [notificationIdentifier rangeOfString:@"_"];
	NSRange idRange = NSMakeRange(prefixRange.location + prefixRange.length, suffixRange.location - prefixRange.location - prefixRange.length);
	return [notificationIdentifier substringWithRange:idRange];
}

- (id)primaryText {
	if (self.snoozeCustomTitle == nil) {
		return %orig;
	}
	return self.snoozeCustomTitle;
}
%end
//DEFEDCA7 ---- 2F15B