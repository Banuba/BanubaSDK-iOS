#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import <BanubaVideoEditorCore/BanubaVideoEditorCore.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSErrorDomain const kVideoWriterErrorDomain;
FOUNDATION_EXPORT NSInteger const kUnknownRecordingErrorCode;
FOUNDATION_EXPORT NSInteger const kNotEnoughSpaceForRecordingErrorCode;

@interface SBVideoWriter : NSObject

@property(assign, nonatomic, readonly) CMTime recorderVideoDuration;

@property(assign, nonatomic, readonly) BOOL isRecording;

- (instancetype)initWithOutputSettings:(VEOutputSettings*)settings
                      recorderSettings:(RecorderSettings*)recorderSettings
            externalAudioConfiguration:(ExternalAudioConfiguration *_Nullable)externalAudiooConfiguration;

- (void)pushAudioSampleBuffer:(CMSampleBufferRef)buffer;
- (void)pushVideoSampleBuffer:(CVPixelBufferRef)buffer;

- (void)prepareInputs:(NSURL*)fileUrl;
- (void)startCapturingScreenWithUrl:(NSURL*)fileUrl
                           progress:(void (^_Nullable)(CMTime))progress
                           didStart:(void (^_Nullable)(void))didStart
                    shouldSkipFrame:(bool (^_Nullable)(void))shouldSkipFrame
                         isFirstRun:(bool)isFirstRun
       periodicProgressTimeInterval:(NSTimeInterval)periodicProgressTimeInterval
                      totalDuration:(NSTimeInterval)totalDuration
                limitReachedHandler:(void (^_Nullable)(void))limitReachedHandler
                         completion:(void (^)(BOOL, NSError*))completionHandler;

- (void)startCapturingScreenWithProgress:(void (^_Nullable)(CMTime))progress
                                didStart:(void (^_Nullable)(void))didStart
                         shouldSkipFrame:(bool (^_Nullable)(void))shouldSkipFrame
                              isFirstRun:(bool)isFirstRun
            periodicProgressTimeInterval:(NSTimeInterval)periodicProgressTimeInterval
                           totalDuration:(NSTimeInterval)totalDuration
                     limitReachedHandler:(void (^_Nullable)(void))limitReachedHandler
                              completion:(void (^)(BOOL, NSError*))completionHandler;
- (void)stopCapturing;
- (void)discardCapturing;
+ (BOOL)isEnoughDiskSpaceForRecording;

@end

NS_ASSUME_NONNULL_END
