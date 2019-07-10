# HandFinder
Vision +  ML  = 🤚:D 
这就是用 Vision 和 机器学习模型弄出来的小玩意.(感谢 hands_cnn.mlmodel 这个重要文件的作者 https://github.com/ishansharma/Hand-Detection)
可以通过摄像头,和图片识别🤚. 左右🤚, 正反🤚.

第一次传, 实在是搓逼的很.
一脸懵逼, 实在是心虚的很.
好歹是 pod init 就能用. 用着也简单. 单单就一行代码,马上就好用,用完给个Star :D .

#安装
pod 'HandFinder'

#使用 
#import "HandFinder/HandFinder.h"

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ///Dont forget ------  Privacy - Camera Usage Description ----
    [[HandFinder shareInstance] startSessionWithView:self.view ValueChange:^(HandFinderModel * _Nonnull model) {
        //model里面有 left, right, back, front, hand.  
    }];
    
    ///Used Image  :D
//    [[HandFinder shareInstance] startSessionWithSourceIMG:[UIImage imageNamed:@"hand"] ValueChange:^(HandFinderModel * _Nonnull model) {
//
//    }];
    
}

再次感谢 hands_cnn.mlmodel 这个重要文件的作者 https://github.com/ishansharma/Hand-Detection)

------------------------------------------------------------------------------------
Vision + ML = 🤚 : D
This is out with a Vision and machine learning model of gadgets. (thanks to hands_cnn. Mlmodel https://github.com/ishansharma/Hand-Detection), the author of this important document
Can through the camera, and image recognition 🤚. Around 🤚, positive and negative 🤚.

The first pass, is really rub force very much.
A face meng, is really guilty very much.
Well, at least it works. It's easy to use. Just one line of code.

# installation
pod 'HandFinder'

# use
H # import "HandFinder/HandFinder."

- (void) viewDidLoad {
[super viewDidLoad];
Do any additional setup after loading the view.

/// don't forget ------ Privacy -- Camera Usage Description
[[HandFinder shareInstance] startSessionWithView: self view ValueChange: ^ (HandFinderModel * _Nonnull model) {
// the model has left, right, back, front, hand.
}];

/ / / 2 Image: D
/ / [[HandFinder shareInstance] startSessionWithSourceIMG: [UIImage imageNamed: @ "hand"] ValueChange: ^ (HandFinderModel * _Nonnull model) {
//
/ /}];

}

Thank you again for hands_cnn. Mlmodel https://github.com/ishansharma/Hand-Detection), the author of this important document
