//


#import <UIKit/UIKit.h>


@interface Alert : UIView

@property(nonatomic,strong)NSString *message;

//+(instancetype)sharedAlert;

+(void)showAlert:(NSString *)message;
+(void)showAlert:(NSString *)message toView:(UIView *)view;
+(void)showAlert:(NSString *)message toView:(UIView *)view center:(CGPoint)center;

@end
