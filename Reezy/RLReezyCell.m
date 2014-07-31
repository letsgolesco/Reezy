//
//  RLReezyCell.m
//  Reezy
//
//  Created by Richard on 2014-07-31.
//  Copyright (c) 2014 Richard Lesco. All rights reserved.
//

#import "RLReezyCell.h"

@interface RLReezyCell () <AVAudioRecorderDelegate>

@end

@implementation RLReezyCell

#pragma mark - AVAudioRecorderDelegate methods

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    if (flag == YES) {
        self.hasAudio = YES;
        self.audioPlayer = [self setupPlayerForFile:self.audioFilePath];
    }
}

#pragma mark - Audio recorder methods

- (AVAudioRecorder *) setupRecorderForFile:(NSString *)filePath {
    NSURL *url = [[NSURL alloc] initFileURLWithPath:filePath];
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithInt:AVAudioQualityMedium],
                              AVEncoderAudioQualityKey,
                              [NSNumber numberWithInt:16],
                              AVEncoderBitRateKey,
                              [NSNumber numberWithInt:1],
                              AVNumberOfChannelsKey,
                              [NSNumber numberWithFloat:44100.0f],
                              AVSampleRateKey, nil];
    NSError *err = nil;
    AVAudioRecorder *newRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&err];
    newRecorder.delegate = self;
    return newRecorder;
}

#pragma mark - Audio player methods

- (AVAudioPlayer *) setupPlayerForFile:(NSString *)filePath {
    NSURL *url = [[NSURL alloc] initFileURLWithPath:filePath];
    NSError *playerInitErr = nil;
    AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&playerInitErr];
    return newPlayer;
}


#pragma mark - Given methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
