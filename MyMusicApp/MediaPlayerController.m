//
//  DetailViewController.m
//  UICollectionView
//
//  Created by Mac on 22/08/16.
//  Copyright © 2016 PeersTech. All rights reserved.
//

#import "MediaPlayerController.h"

@interface MediaPlayerController ()

@end

@implementation MediaPlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@" Selected file ====> %@", _musicFile.title);
    NSURL *url = [_musicFile valueForProperty:MPMediaItemPropertyAssetURL];

    
    MPMediaItemArtwork *artwork = [_musicFile valueForKey:MPMediaItemPropertyArtwork];
    UIImage *albumArtworkImage = nil;
    
    if (artwork != nil) {
        albumArtworkImage = [artwork imageWithSize:artwork.bounds.size];
    }
    
    if (albumArtworkImage == nil) {
         albumArtworkImage = [UIImage imageNamed:@"defaultSongArtwork"];
    } else { // no album artwork
        NSLog(@"No ALBUM ARTWORK");
       
    }
    
    _songImage.image = albumArtworkImage;
    
    _songTitle.text = [_musicFile valueForKey:MPMediaItemPropertyTitle];
   
    NSLog(@"PlayBack time %@", [_musicFile valueForKey:MPMediaItemPropertyPlaybackDuration]);
   
    audioPlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                       error:nil];
    
    [audioPlayer prepareToPlay];
    [self setSlider];
   
    audioPlayer.volume=0.5;
    
    [audioPlayer play];
    

}
- (void)viewWillDisappear:(BOOL)animated
{
    if(timer)
    {
        [timer invalidate];
        timer = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)volumeSliderAction:(id)sender {
   // NSLog(@"Volume slider value %f",_volumeSlider.value);
     audioPlayer.volume=_volumeSlider.value/1.0;
}

- (IBAction)playPauseButtonAction:(id)sender {
    
    if ([audioPlayer isPlaying]) {
        [audioPlayer pause];
        [_playPauseButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        
    }
    else
    {
        [audioPlayer play];
        [_playPauseButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        
    }
}


- (IBAction)songPositionSliderAction:(id)sender {
   
    [audioPlayer setCurrentTime: _songPosition.value];

}
-(void)setSlider{
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self    selector:@selector(updateSlider) userInfo:nil repeats:YES];
    
    _songPosition.minimumValue = 0.0f;
    _songPosition.maximumValue = [[_musicFile valueForKey:MPMediaItemPropertyPlaybackDuration] floatValue];
   
    [_songPosition addTarget:self action:@selector(songPositionSliderAction:) forControlEvents:UIControlEventValueChanged];
    _timeElapsed.text = [self timeFormatted:0.0f];
    _timeRemaining.text = [NSString stringWithFormat:@"-%@", [self timeFormatted: _songPosition.maximumValue]];
    
    _songPosition.continuous = YES;
}

- (void)updateSlider {
    
   // _songPosition.maximumValue = [[_musicFile valueForKey:MPMediaItemPropertyPlaybackDuration] floatValue];
    _songPosition.value = (float)audioPlayer.currentTime;
    _timeElapsed.text = [self timeFormatted:[audioPlayer currentTime]];
    
    _timeRemaining.text = [NSString stringWithFormat:@"-%@", [self timeFormatted: _songPosition.maximumValue - [audioPlayer currentTime]]];
}

- (NSString *)timeFormatted:(float)totalSeconds
{
    
    int seconds = (int)totalSeconds % 60;
    int minutes = (int)(totalSeconds / 60) % 60;
    
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}


@end
