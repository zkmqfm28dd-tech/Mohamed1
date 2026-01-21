#include <UIKit/UIKit.h>
#include < substrate.h>

static bool espEnabled = false;
static bool aimEnabled = false;
static bool recEnabled = false;

// Last Island v2.30 offsets (adjust if different)
#define ESP_ADDR  (void*)0x104B7A4C4
#define AIM_ADDR  (void*)0x104B7A4D0
#define REC_ADDR  (void*)0x104B7A4DC

static void applyCheats() {
    *(bool*)ESP_ADDR = espEnabled;
    *(float*)AIM_ADDR = aimEnabled ? 3.5f : 0.0f;
    *(bool*)REC_ADDR = recEnabled;
}

@interface AIProMenu : NSObject
+ (void)showMenu;
+ (void)toggleMenu;
@end

@implementation AIProMenu
+ (void)showMenu {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(window.bounds.size.width - 70, window.bounds.size.height - 140, 50, 50);
    btn.layer.cornerRadius = 25;
    btn.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.5];
    [btn setTitle:@"☰" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toggleMenu) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn];
}

+ (void)toggleMenu {
    UIAlertController *menu = [UIAlertController alertControllerWithTitle:@"AI-Pro Menu"
                                                                  message:nil
                                                           preferredStyle:UIAlertControllerStyleActionSheet];
    [menu addAction:[UIAlertAction actionWithTitle:(espEnabled ? @"🔲 ESP OFF" : @"✅ ESP ON")
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction *action){
                                                     espEnabled = !espEnabled;
                                                     applyCheats();
                                                 }]];
    [menu addAction:[UIAlertAction actionWithTitle:(aimEnabled ? @"🔲 Aim OFF" : @"✅ Aim ON")
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction *action){
                                                     aimEnabled = !aimEnabled;
                                                     applyCheats();
                                                 }]];
    [menu addAction:[UIAlertAction actionWithTitle:(recEnabled ? @"🔲 Recoil OFF" : @"✅ Recoil ON")
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction *action){
                                                     recEnabled = !recEnabled;
                                                     applyCheats();
                                                 }]];
    [menu addAction:[UIAlertAction actionWithTitle:@"إخفاء" style:UIAlertActionStyleCancel handler:nil]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:menu animated:YES completion:nil];
}
@end

__attribute__((constructor))
static void ctor() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [AIProMenu showMenu];
    });
}
