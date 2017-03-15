//
//  RNAudioPlayer.h
//  RNAudioPlayer
//
//  Created by eegoma on 2017. 3. 16..
//  Copyright © 2017년 eegoma. All rights reserved.
//

#import <React/RCTBridgeModule.h>
@import AVFoundation;


@interface RNAudioPlayer : NSObject <RCTBridgeModule>

@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) AVPlayer *player;
@property (nonatomic, readwrite) BOOL isPlayingWithOthers;

@end
