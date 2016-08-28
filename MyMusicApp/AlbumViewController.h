//
//  AlbumViewController.h
//  MyMusicApp
//
//  Created by Niranjan on 28/08/16.
//  Copyright © 2016 PeersTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaAccessibility/MediaAccessibility.h>
@import MediaPlayer;
@interface AlbumViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

{
        
    NSArray<MPMediaItemCollection *> *allAlbumsArray;
}
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@end
