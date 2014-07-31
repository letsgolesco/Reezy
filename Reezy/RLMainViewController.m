//
//  RLMainViewController.m
//  Reezy
//
//  Created by Richard on 2014-07-31.
//  Copyright (c) 2014 Richard Lesco. All rights reserved.
//

#import "RLMainViewController.h"

static NSString *CELLIDENTIFIER = @"CELLIDENTIFIER";

@interface RLMainViewController () <UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *colors;

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
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CELLIDENTIFIER];
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.collectionView];

    // Gesture recognizers
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.1f;
    [self.collectionView addGestureRecognizer:lpgr];
}

#pragma mark - Gesture recognizer handling

- (void) handleLongPress:(UILongPressGestureRecognizer *)lpgr {
    CGPoint p = [lpgr locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];

    [UIView animateWithDuration:0.1f animations:^{
        float diff = 20.0f;
        if (lpgr.state == UIGestureRecognizerStateBegan) {
            cell.bounds = CGRectInset(cell.bounds, diff, diff);
        } else if (lpgr.state == UIGestureRecognizerStateEnded) {
            cell.bounds = CGRectInset(cell.bounds, -diff, -diff);
        }
    }];
}

#pragma mark - Given methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    self.colors = [NSArray arrayWithObjects:[UIColor redColor],
                                            [UIColor greenColor],
                                            [UIColor blueColor],
                                            [UIColor purpleColor],
                                            [UIColor yellowColor],
                                            [UIColor cyanColor],
                                            [UIColor magentaColor],
                                            [UIColor whiteColor], nil];
    [self setupCollectionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELLIDENTIFIER forIndexPath:indexPath];
    cell.backgroundColor = [self.colors objectAtIndex:indexPath.item];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
