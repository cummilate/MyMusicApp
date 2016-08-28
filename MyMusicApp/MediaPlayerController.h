//
//  DetailViewController.h
//  UICollectionView
//
//  Created by Mac on 22/08/16.
//  Copyright © 2016 PeersTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaAccessibility/MediaAccessibility.h>
@import MediaPlayer;

@interface MediaPlayerController : UIViewController
{
    AVAudioPlayer *audioPlayer;
    NSTimer *timer;
}

@property (weak, nonatomic) IBOutlet UIImageView *songImage;

@property (weak, nonatomic) IBOutlet UILabel *songTitle;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@property (weak, nonatomic) IBOutlet UISlider *songPosition;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;

- (IBAction)volumeSliderAction:(id)sender;
- (IBAction)playPauseButtonAction:(id)sender;
- (IBAction)songPositionSliderAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *timeElapsed;
@property (weak, nonatomic) IBOutlet UILabel *timeRemaining;
@property(nonatomic) MPMediaItem *musicFile;
@end
