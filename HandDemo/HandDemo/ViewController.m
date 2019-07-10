//
//  ViewController.m
//  HandDemo
//
//  Created by BCZ on 2019/7/9.
//  Copyright © 2019 HFS. All rights reserved.
//

#import "ViewController.h"
#import "HandFinder/HandFinder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ///Dont forget ------  Privacy - Camera Usage Description ----
    [[HandFinder shareInstance] startSessionWithView:self.view ValueChange:^(HandFinderModel * _Nonnull model) {
        
    }];
    
    ///Used Image  :D
//    [[HandFinder shareInstance] startSessionWithSourceIMG:[UIImage imageNamed:@"hand"] ValueChange:^(HandFinderModel * _Nonnull model) {
//
//    }];
    
}


@end
