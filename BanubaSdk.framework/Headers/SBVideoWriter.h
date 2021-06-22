#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSErrorDomain const kVideoWriterErrorDomain;
FOUNDATION_EXPORT NSInteger const kUnknownRecordingErrorCode;
FOUNDATION_EXPORT NSInteger const kNotEnoughSpaceForRecordingErrorCode;

@interface OutputSettings : NSObject

@property(nonatomic) UIDeviceOrientation deviceOrientation;
@property(nonatomic) BOOL isMirrored;
@property(nonatomic) BOOL applyWatermark;

@property(nonatomic, readonly) BOOL shouldApplyVerticalFlip;
@property(nonatomic, readonly) BOOL shouldApplyHorizontalFlip;
@property(nonatomic, readonly) CGAffineTransform resultVideoTransform;
@property(nonatomic, readonly) UIImageOrientation resultImageOrientation;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithOrientation:(UIDeviceOrientation)orientation
                         isMirrored:(BOOL)isMirrored
                     applyWatermark:(BOOL)applyWatermark NS_DESIGNATED_INITIALIZER;

@end

@interface RecorderSettings : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithVideoDataOutput:(AVCaptureVideoDataOutput* _Nullable)videoDataOutput
                            captureSize:(CGSize)captureSize
                 useHEVCCodecIfPossible:(BOOL)useHEVCCodecIfPossible;

@end

@interface SBVideoWriter : NSObject

@property(assign, nonatomic, readonly) CMTime recorderVideoDuration;

- (instancetype)initWithOutputSettings:(OutputSettings*)settings
                      recorderSettings:(RecorderSettings*)recorderSettings;

- (void)pushAudioSampleBuffer:(CMSampleBufferRef)buffer;
- (void)pushVideoSampleBuffer:(CVPixelBufferRef)buffer;

- (void)prepareInputs:(NSURL*)fileUrl;
- (void)startCapturingScreenWithUrl:(NSURL*)fileUrl
                           progress:(void (^_Nullable)(CMTime))progress
                           didStart:(void (^_Nullable)(void))didStart
       periodicProgressTimeInterval:(NSTimeInterval)periodicProgressTimeInterval
                      boundaryTimes:(NSArray<NSValue*>* _Nullable)boundaryTimes
                    boundaryHandler:(void (^_Nullable)(CMTime))boundaryHandler
                      totalDuration:(NSTimeInterval)totalDuration
                limitReachedHandler:(void (^_Nullable)(void))limitReachedHandler
                         completion:(void (^)(BOOL, NSError*))completionHandler;

- (void)startCapturingScreenWithProgress:(void (^_Nullable)(CMTime))progress
                                didStart:(void (^_Nullable)(void))didStart
            periodicProgressTimeInterval:(NSTimeInterval)periodicProgressTimeInterval
                           boundaryTimes:(NSArray<NSValue*>* _Nullable)boundaryTimes
                         boundaryHandler:(void (^_Nullable)(CMTime))boundaryHandler
                           totalDuration:(NSTimeInterval)totalDuration
                     limitReachedHandler:(void (^_Nullable)(void))limitReachedHandler
                              completion:(void (^)(BOOL, NSError*))completionHandler;
- (void)stopCapturing;
- (void)discardCapturing;
+ (BOOL)isEnoughDiskSpaceForRecording;

@end

NS_ASSUME_NONNULL_END
