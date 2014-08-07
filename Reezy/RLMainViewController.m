//
//  RLMainViewController.m
//  Reezy
//
//  Created by Richard on 2014-07-31.
//  Copyright (c) 2014 Richard Lesco. All rights reserved.
//

#import "RLMainViewController.h"

#import <AVFoundation/AVFoundation.h>

#import "RLReezyCell.h"

static NSString *RLReezyCellIdentifier = @"RLReezyCellIdentifier";

@interface RLMainViewController () <UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) UIImage *image;

@end

@implementation RLMainViewController

#pragma mark - UI Setup methods

- (void) setupCollectionView {
    // Layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    float screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    float screenHeight = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    layout.itemSize = CGSizeMake(screenWidth/2, screenHeight/4);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;

    // Collection View
    self.collectionView = [[UICollectionView alloc] initWithFrame:[[UIScreen mainScreen] bounds] collectionViewLayout:layout];
    [self.collectionView registerClass:[RLReezyCell class] forCellWithReuseIdentifier:RLReezyCellIdentifier];
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.collectionView];
}

#pragma mark - Given methods

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Deal with AVAudioSession
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *setCategoryErr = nil;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&setCategoryErr];
    NSError *setActiveErr;
    [session setActive:YES error:&setActiveErr];

    // Colors yo
    self.view.backgroundColor = [UIColor blackColor];
    self.colors = [NSArray arrayWithObjects:[UIColor redColor],
                                            [UIColor greenColor],
                                            [UIColor blueColor],
                                            [UIColor purpleColor],
                                            [UIColor yellowColor],
                                            [UIColor cyanColor],
                                            [UIColor magentaColor],
                                            [UIColor orangeColor], nil];
    // Make dem cells
    self.image = [UIImage imageNamed:@"Microphone"];
    [self setupCollectionView];
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.colors.count;
}

/* TODO: Ideally move as much of this code as possible into the Cell class */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RLReezyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RLReezyCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [self.colors objectAtIndex:indexPath.item];

    NSURL *docsUrl = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSString *cellNum = [NSString stringWithFormat:@"%ld", (long)indexPath.item];
    NSString *fileName = [cellNum stringByAppendingString:@".wav"];
    cell.audioFilePath = [docsUrl.path stringByAppendingPathComponent:fileName];
    cell.hasAudio = NO;

    // Gesture recognizer
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:cell action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.0f;
    lpgr.cancelsTouchesInView = NO;
    lpgr.delaysTouchesEnded = NO;
    lpgr.delaysTouchesBegan = YES;
    cell.lpgr = lpgr;
    [cell addGestureRecognizer:lpgr];

    // Microphone image
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
    imageView.center = cell.contentView.center;
    [cell addSubview:imageView];
    cell.imageView = imageView;

    return cell;
}

@end
