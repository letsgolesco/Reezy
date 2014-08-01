//
//  RLReezyCell.h
//  Reezy
//
//  Created by Richard on 2014-07-31.
//  Copyright (c) 2014 Richard Lesco. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

@interface RLReezyCell : UICollectionViewCell

@property (nonatomic, strong) NSString *audioFilePath;
@property (nonatomic, assign) BOOL hasAudio;

@property (nonatomic, strong) AVAudioRecorder *audioRecorder; // Should this be a weak reference? I hope it gets released after recording...
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (nonatomic, strong) UIImageView *imageView;

- (AVAudioRecorder *) setupRecorderForFile:(NSString *)filePath;
- (void) handleLongPress:(UILongPressGestureRecognizer *)lpgr;

@end
