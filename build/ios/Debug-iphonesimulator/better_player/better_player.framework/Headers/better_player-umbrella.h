#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BetterPlayer.h"
#import "BetterPlayerEzDrmAssetsLoaderDelegate.h"
#import "BetterPlayerPlugin.h"
#import "BetterPlayerTimeUtils.h"
#import "BetterPlayerView.h"

FOUNDATION_EXPORT double better_playerVersionNumber;
FOUNDATION_EXPORT const unsigned char better_playerVersionString[];

