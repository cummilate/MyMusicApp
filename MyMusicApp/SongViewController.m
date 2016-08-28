//
//  CollectionViewController.m
//  UICollectionView
//
//  Created by Mac on 22/08/16.
//  Copyright © 2016 PeersTech. All rights reserved.
//

#import "SongViewController.h"
#import <MediaAccessibility/MediaAccessibility.h>


@import MediaPlayer;
@interface SongViewController ()

@end

@implementation SongViewController

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
    // Do any additional setup after loading the view.
    NSLog(@"Loading Album Files ======");
    
    
   /* musicFiles=[[NSMutableArray<MPMediaItem *> alloc]init];
    
    
    
    MPMediaQuery *fullList = [MPMediaQuery songsQuery];
    
    NSArray *mediaList = [fullList items];
    int count = 0;
    for (MPMediaItem *song in mediaList) {
        NSString *songTitle = [song valueForProperty: MPMediaItemPropertyTitle];
        NSString *songArtist = [song valueForProperty: MPMediaItemPropertyArtist];
        count = count+1;
        [musicFiles addObject:song];
        NSLog (@"%d. %@ \"%@\"", count, songArtist, songTitle);
    }
    */
   
    musicFiles = [_mediaItemCollection items];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return musicFiles.count;
   // return _mediaItemCollection.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    MPMediaItem *musicFile = [musicFiles objectAtIndex:indexPath.row];
    
    UIImageView *imgView = (UIImageView *)[cell viewWithTag:100];
    
    MPMediaItemArtwork *artwork = [musicFile valueForKey:MPMediaItemPropertyArtwork];
    
    UIImage *albumArtworkImage = nil;
    
    if (artwork != nil) {
        albumArtworkImage = [artwork imageWithSize:artwork.bounds.size];
    }
    
    if (albumArtworkImage == nil) {
        albumArtworkImage = [UIImage imageNamed:@"defaultAlbumArtwork"];
    } else { // no album artwork
        NSLog(@"No ALBUM ARTWORK");
    }
    imgView.image = albumArtworkImage;
   // imgView.image = [UIImage imageNamed:@"music"];
    
    UILabel *name = (UILabel *)[cell viewWithTag:101];
    name.text = musicFile.title;
    
    
    
    return cell;
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = self.collectionView.indexPathsForSelectedItems.firstObject;
    
       
        MediaPlayerController *controller = [segue destinationViewController];//(DetailViewController *)[[segue destinationViewController] topViewController];
       controller.musicFile   = [musicFiles objectAtIndex:indexPath.row];
       // controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
       // controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
