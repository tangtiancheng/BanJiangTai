//
//  XPQRCaptureView.m
//  XPApp
//
//  Created by huangxinping on 15/5/15.
//  Copyright (c) 2015年 iiseeuu.com. All rights reserved.
//

#import "XPQRCaptureView.h"
#import <AVFoundation/AVFoundation.h>

@interface XPQRCaptureView () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) NSString *formerResult;

@end

@implementation XPQRCaptureView

#pragma mark - LifeCircle
- (instancetype)init
{
    if((self = [super init])) {
        [self initializeCapture];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self initializeCapture];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self initializeCapture];
    }
    
    return self;
}

- (void)startCaptureWithDelegate:(id <XPQRCaptureViewDelegate> )delegate
{
    [_session startRunning];
    _delegate = delegate;
}

- (void)startCapture
{
    [_session startRunning];
}

- (void)stopCapture
{
    [_session stopRunning];
    _session = nil;
    
    [_previewLayer removeFromSuperlayer];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if(metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *meta = metadataObjects[0];
        if([[meta type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            [self performSelectorOnMainThread:@selector(didGetQRCaptureResult:) withObject:[meta stringValue] waitUntilDone:NO];
        }
    }
}

# pragma mark - Private Methods
- (void)initializeCapture
{
    AVCaptureSession *session = [self setupSession];
    if(!session) {
        return;
    }
    
    [self.layer addSublayer:[self setupPreviewLayer]];
    [self setupConnection];
}

- (AVCaptureSession *)setupSession
{
    AVCaptureDeviceInput *input = [self setupInput];
    if(!input) {
        return nil;
    }
    
    _session = [AVCaptureSession new];
    [_session addInput:input];
    [self setupMetadataOutput];
    return _session;
}

- (AVCaptureDeviceInput *)setupInput
{
    NSError *error;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    return [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
}

- (AVCaptureVideoPreviewLayer *)setupPreviewLayer
{
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    [_previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_previewLayer setFrame:self.bounds];
    return _previewLayer;
}

- (AVCaptureMetadataOutput *)setupMetadataOutput
{
    AVCaptureMetadataOutput *output = [AVCaptureMetadataOutput new];
    // should call -addOutput before -setMetadataObjectTypes
    // @url http://www.ama-dev.com/iphone-qr-code-library-ios-7/
    
    [_session addOutput:output];
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("KIFastQRCapture", NULL);
    [output setMetadataObjectsDelegate:self queue:dispatchQueue];
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    return output;
}

- (AVCaptureConnection *)setupConnection
{
    AVCaptureConnection *connection = _previewLayer.connection;
    connection.videoOrientation = AVCaptureVideoOrientationPortrait;
    return connection;
}

- (void)didGetQRCaptureResult:(NSString *)result
{
    if([_formerResult isEqualToString:result]) {
        return;
    }
    
    _formerResult = result;
    if(_delegate && [_delegate respondsToSelector:@selector(qrView:captureOutput:)]) {
        [_delegate qrView:self captureOutput:result];
    }
}

@end
