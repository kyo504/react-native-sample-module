#import "RNAudioPlayer.h"
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTEventEmitter.h>
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@implementation RNAudioPlayer

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (RNAudioPlayer *)init {
    return [super init];
}

#pragma mark - Pubic API

RCT_EXPORT_METHOD(play:(NSString *) url) {
    NSURL *soundUrl = [[NSURL alloc] initWithString:url];
    self.playerItem = [AVPlayerItem playerItemWithURL:soundUrl];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    
    [self.player play];
    [self.bridge.eventDispatcher sendDeviceEventWithName: @"onPlaybackStateChanged"
                                                    body: @{@"state": @"PLAYING" }];
}

RCT_EXPORT_METHOD(pause) {
    [self.player pause];
    [self.bridge.eventDispatcher sendDeviceEventWithName: @"onPlaybackStateChanged"
                                                    body: @{@"state": @"PAUSED" }];
}

RCT_EXPORT_METHOD(isPlaying:(RCTResponseSenderBlock) callback)
{
    NSMutableDictionary *events = [[NSMutableDictionary alloc] init];

    if (self.player != nil && self.player.rate != 0) {
        events[@"playing"] = @YES;
    } else {
        events[@"playing"] = @NO;
    }

    callback(@[events]);
}
@end
