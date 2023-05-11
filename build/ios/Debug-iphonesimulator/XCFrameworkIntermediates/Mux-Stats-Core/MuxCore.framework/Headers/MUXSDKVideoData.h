#ifndef MUXSDKVideoData_h
#define MUXSDKVideoData_h

#import "MUXSDKQueryData.h"
#import <Foundation/Foundation.h>
#import "MUXSDKUpsertable.h"

extern NSString * _Nonnull VIDEO_SOURCE_ADVERTISED_BITRATE;
extern NSString * _Nonnull VIDEO_SOURCE_ADVERTISED_FRAMERATE;
extern NSString * _Nonnull VIDEO_SOURCE_HEIGHT;
extern NSString * _Nonnull VIDEO_SOURCE_WIDTH;

@interface MUXSDKVideoData : MUXSDKQueryData<MUXSDKUpsertable>

@property (nullable) NSString *videoPosterUrl;
@property (nullable) NSNumber *videoSourceFrameDrops;
@property (nullable) NSString *videoSourceDomain;
@property (nullable) NSNumber *videoSourceDuration;
@property (nullable) NSNumber *videoSourceHeight;
@property (nullable) NSString *videoSourceHostName;
@property (nullable) NSString *videoSourceIsLive;
@property (nullable) NSString *videoSourceMimeType;
@property (nullable) NSString *videoSourceUrl;
@property (nullable) NSNumber *videoSourceWidth;
@property (nullable) NSNumber *videoSourceAdvertisedBitrate;
@property (nullable) NSNumber *videoSourceAdvertisedFrameRate;
@property (nullable) NSString *internalVideoExperiments;

@end
#endif
