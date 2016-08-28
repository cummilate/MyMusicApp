//
//  CollectionViewController.h
//  UICollectionView
//
//  Created by Mac on 22/08/16.
//  Copyright © 2016 PeersTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaAccessibility/MediaAccessibility.h>
#import "MediaPlayerController.h"
@import MediaPlayer;

@interface SongViewController : UICollectionViewController
{
    NSArray<MPMediaItem *> *musicFiles;
    
}
@property(nonatomic) MPMediaItemCollection *mediaItemCollection;
@end
