//
//  Themes.h
//  TinkoffChat
//
//  Created by m.kuznetsov1 on 22.03.2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Themes : NSObject

-(void) setTheme1: (UIColor*) theme;
-(void) setTheme2: (UIColor*) theme;
-(void) setTheme3: (UIColor*) theme;

-(UIColor*) getTheme1;
-(UIColor*) getTheme2;
-(UIColor*) getTheme3;

@end
