
#import "RNAudioPlayer.h"
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTEventEmitter.h>
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface RNAudioPlayer() {
}

@end

@implementation RNAudioPlayer

@synthesize bridge = _bridge;


RCT_EXPORT_MODULE();

- (RNAudioPlayer *)init {
    self = [super init];
    return self;
}

#pragma mark - Pubic API

RCT_EXPORT_METHOD(play:(NSString *)url) {
    if(!([url length]>0)) return;
    
    NSURL *soundUrl = [[NSURL alloc] initWithString:url];
    self.playerItem = [AVPlayerItem playerItemWithURL:soundUrl];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    
    soundUrl = nil;
}

RCT_EXPORT_METHOD(play) {
    [self.player play];
    
    [self.bridge.eventDispatcher sendDeviceEventWithName: @"onPlaybackStateChanged"
                                                    body: @{@"state": @"PLAYING" }];
}

RCT_EXPORT_METHOD(pause) {
    [self.player pause];
    
    [self.bridge.eventDispatcher sendDeviceEventWithName: @"onPlaybackStateChanged"
                                                    body: @{@"state": @"PAUSED" }];
}
