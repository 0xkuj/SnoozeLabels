#import <Foundation/Foundation.h>

@interface SBScheduledAlarmObserver
+(id)sharedInstance;
@end

@interface MTAlarm 
@property (nonatomic, copy, readwrite) NSString *title;
@end

@interface MTMutableAlarm : MTAlarm
@end

@interface MTAlarmManager
- (id)alarmWithIDString:(id)arg1;
@end

@interface NCNotificationRequest 
-(NSString *)notificationIdentifier;
@end

@interface NCNotificationRequestContentProvider : NSObject 
- (id)notificationRequest;
@end

@interface NCSnoozeAlarmNotificationStaticContentProvider : NCNotificationRequestContentProvider
- (void)initAlarmManagerIfNeeeded;
+ (NSString *)getIdFromNotificationIdentifier:(NSString *)notificationIdentifier;
@property (nonatomic) NSString *snoozeCustomTitle;
@end