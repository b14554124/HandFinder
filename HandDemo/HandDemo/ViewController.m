//
//  ViewController.m
//  HandDemo
//
//  Created by BCZ on 2019/7/9.
//  Copyright © 2019 HFS. All rights reserved.
//

#import "ViewController.h"
#import "HandFinder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [[HandFinder shareInstance] startSessionWithView:self.view ValueChange:^(HandFinderModel * _Nonnull model) {
        
    }];
    
    
    [[HandFinder shareInstance] startSessionWithSourceIMG:[UIImage imageNamed:@"hand"] ValueChange:^(HandFinderModel * _Nonnull model) {
        
    }];
    
}


@end
