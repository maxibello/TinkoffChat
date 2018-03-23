//
//  ThemesViewController.h
//  TinkoffChat
//
//  Created by m.kuznetsov1 on 22.03.2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Themes.h"
#import "ThemesViewControllerDelegate.h"

@interface ThemesViewController : UIViewController
    @property (retain, nonatomic) Themes *model;
    @property (retain, nonatomic) id<ThemesViewControllerDelegate> delegate;
@end
