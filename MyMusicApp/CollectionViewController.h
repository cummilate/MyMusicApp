//
//  CollectionViewController.h
//  UICollectionView
//
//  Created by Mac on 22/08/16.
//  Copyright © 2016 PeersTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaAccessibility/MediaAccessibility.h>
@import MediaPlayer;
@interface CollectionViewController : UICollectionViewController
{
    NSMutableArray<MPMediaItem *> *musicFiles;
}
@end
