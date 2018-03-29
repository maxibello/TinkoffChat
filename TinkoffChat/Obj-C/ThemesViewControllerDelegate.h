//
//  ThemesViewControllerDelegate.h
//  TinkoffChat
//
//  Created by m.kuznetsov1 on 22.03.2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

#import "ThemesViewController.h"

@class ThemesViewController;

@protocol ThemesViewControllerDelegate <NSObject>
- (void)themesViewController:(ThemesViewController *)controller didSelectTheme:(UIColor *)selectedTheme;
@end
