#import <React/RCTBridgeModule.h>
@import AVFoundation;

@interface RNAudioPlayer : NSObject <RCTBridgeModule>

@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) AVPlayer *player;

@end
