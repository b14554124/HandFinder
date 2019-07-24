//
//  SMHandFinder.m
//  SMHoroscope
//
//  Created by BCZ on 2018/11/26.
//  Copyright © 2018 SM. All rights reserved.
//

#import "HandFinder.h"
#import <AVFoundation/AVFoundation.h>
#import <Vision/Vision.h>
#import "hands_cnn.h"



@interface HandFinder ()<AVCaptureVideoDataOutputSampleBufferDelegate>

//摄像头会话
@property (nonatomic, strong) AVCaptureSession *session;
//摄像头Layer
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) NSArray <VNRequest *>*visionRequests;

@property (nonatomic, assign) float recognitionThreshold;

@property (nonatomic, strong) dispatch_queue_t queues;


@end

@implementation HandFinder


static HandFinder* _instance = nil;

+(instancetype)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    
    return _instance ;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [HandFinder shareInstance] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [HandFinder shareInstance];
}

- (void)startSessionWithView:(UIView *)superView ValueChange:(valueChange)block {
    
    [self settingCameraSuperView:superView valueChange:block];
    [self updateLayoutToSuperView:superView];
    
}

- (void)startSessionWithSourceIMG:(UIImage *)img ValueChange:(valueChange)block {
    [self loadMLModel:block];
    [self findeHandWithImgRecognition:img];
    

}


- (void)settingCameraSuperView:(UIView *)superView valueChange:(valueChange )block {
    
    AVCaptureDevice *camera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    self.session = [[AVCaptureSession alloc] init];
    
    //视频质量
    self.session.sessionPreset = AVCaptureSessionPresetHigh;
    
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    
    [superView.layer addSublayer:self.previewLayer];
    
    AVCaptureDeviceInput *cameraInput = [[AVCaptureDeviceInput alloc] initWithDevice:camera error:nil];
    
    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    
    _queues = dispatch_queue_create("frameQueue", DISPATCH_QUEUE_SERIAL);
    
    [videoOutput setSampleBufferDelegate:self queue:_queues];
    //丢弃后期帧
    videoOutput.alwaysDiscardsLateVideoFrames = YES;
    
    NSDictionary*settings = @{(__bridge id)kCVPixelBufferPixelFormatTypeKey: @(kCVPixelFormatType_32BGRA)};
    
    videoOutput.videoSettings = settings;
    
    [self.session addInput:cameraInput];
    [self.session addOutput:videoOutput];
    
    AVCaptureConnection *conn = [videoOutput connectionWithMediaType:AVMediaTypeVideo];
    
    conn.videoOrientation = AVCaptureVideoOrientationPortrait;
    
    [self.session startRunning];
    
    [self loadMLModel:block];
}


- (void)loadMLModel:(valueChange )block{
    
    
    //加载机器学习模型
    VNCoreMLModel *visionModel = [VNCoreMLModel modelForMLModel:[hands_cnn new].model error:nil];
    
    
    VNCoreMLRequest *classifierRequest = [[VNCoreMLRequest alloc] initWithModel:visionModel completionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
        
        if (error != nil) {
            return;
        }
        
        
        
        NSArray *observations = request.results;
        if (observations.count == 0) {
            return;
        }
        
        //模型中有5个属性 Back, Front, Right, Left, Hand
        NSArray <VNClassificationObservation *>*temp = [observations subarrayWithRange:NSMakeRange(0, 5)];
        
        dispatch_async(dispatch_get_main_queue(), ^{

            HandFinderModel *mod = [[HandFinderModel alloc] init];
            for (VNClassificationObservation *op in temp) {
                
                if ([op.identifier isEqualToString:@"Left"]) {
                    mod.left = op.confidence;
                } else if ([op.identifier isEqualToString:@"Back"]) {
                    mod.Back = op.confidence;
                } else if ([op.identifier isEqualToString:@"Front"]) {
                    mod.Front = op.confidence;
                } else if ([op.identifier isEqualToString:@"Hand"]) {
                    mod.Hand = op.confidence;
                } else if ([op.identifier isEqualToString:@"Right"]) {
                    mod.Right = op.confidence;
                }
           
            }
            

            block(mod);
            
            
        });
        
    }];
    
    classifierRequest.imageCropAndScaleOption = VNImageCropAndScaleOptionCenterCrop;
    self.visionRequests = @[classifierRequest];
    
}

- (void)stopSession {
    
    [self.session stopRunning];
    
}

- (void)updateLayoutToSuperView:(UIView *)superView {
    
    self.previewLayer.frame = superView.bounds;
    
}


- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    
    
    CVImageBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    NSDictionary *requestOptions = @{};
    
    CFTypeRef cameraData = CMGetAttachment(sampleBuffer, kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, nil);
    
    if (cameraData != nil) {
        requestOptions = @{VNImageOptionCameraIntrinsics : (__bridge id)cameraData};
    }
    
    VNImageRequestHandler *imageRequestHandler = [[VNImageRequestHandler alloc] initWithCVPixelBuffer:pixelBuffer options:requestOptions];
    
    [imageRequestHandler performRequests:self.visionRequests error:nil];
    
}

- (void)findeHandWithImgRecognition:(UIImage *)img {

    VNImageRequestHandler *vnImageRequestHandler = [[VNImageRequestHandler alloc] initWithCGImage:img.CGImage options:@{}];
    
    NSError *error = nil;
    [vnImageRequestHandler performRequests:self.visionRequests error:&error];
    
    if (error) {
        NSLog(@"手掌识别失败 == %@",error.localizedDescription);
    }
    
}



@end
