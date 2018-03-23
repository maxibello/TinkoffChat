//
//  Themes.m
//  TinkoffChat
//
//  Created by m.kuznetsov1 on 22.03.2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

#import "Themes.h"

@implementation Themes
{
    UIColor *theme1, *theme2, *theme3;
}

- (id)init {
    self = [super init];
    if (self) {
        theme1 = [UIColor redColor];
        theme2 = [UIColor yellowColor];
        theme3 = [UIColor blueColor];
    }
    return self;
}

- (void)dealloc {
    [theme1 release];
    [theme2 release];
    [theme3 release];
    [super dealloc];
}


- (void) setTheme1: (UIColor*) theme {
    if (theme1 != theme) {
        [theme1 release];
        theme1 = [theme retain];
    }
}

- (void) setTheme2: (UIColor*) theme {
    if (theme2 != theme) {
        [theme2 release];
        theme2 = [theme retain];
    }
}

- (void) setTheme3: (UIColor*) theme {
    if (theme3 != theme) {
        [theme3 release];
        theme3 = [theme retain];
    }
}

- (UIColor*) getTheme1 {
    return theme1;
}

- (UIColor*) getTheme2 {
    return theme2;
}

- (UIColor*) getTheme3 {
    return theme3;
}

@end
