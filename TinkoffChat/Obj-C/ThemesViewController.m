//
//  ThemesViewController.m
//  TinkoffChat
//
//  Created by m.kuznetsov1 on 22.03.2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

#import "ThemesViewController.h"
#import "Themes.h"

@implementation ThemesViewController
{
    Themes*  themes;
}

@synthesize delegate = _delegate;

- (void) setDelegate:(id<ThemesViewControllerDelegate>)delegate {
    if (_delegate != delegate) {
        [_delegate release];
        _delegate = [delegate retain];
    }
}

- (id<ThemesViewControllerDelegate>) getDelegate {
    return _delegate;
}

- (void) dealloc {
    [_delegate release];
    [themes release];
    [super dealloc];
}

- (IBAction)them1ButtonClick:(id)sender {
    self.view.backgroundColor = themes.getTheme1;
    [_delegate themesViewController:self didSelectTheme:themes.getTheme1];
}
- (IBAction)theme2ButtonClick:(id)sender {
    self.view.backgroundColor = themes.getTheme2;
    [_delegate themesViewController:self didSelectTheme:themes.getTheme2];
}
- (IBAction)theme3ButtonClick:(id)sender {
    self.view.backgroundColor = themes.getTheme3;
    [_delegate themesViewController:self didSelectTheme:themes.getTheme3];
}
- (IBAction)closeButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Themes";
    themes = [[Themes alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
