//
//  CollectionViewController.m
//  UICollectionView
//
//  Created by Mac on 22/08/16.
//  Copyright © 2016 PeersTech. All rights reserved.
//

#import "CollectionViewController.h"
#import <MediaAccessibility/MediaAccessibility.h>
#import "DetailViewController.h"

@import MediaPlayer;
@interface CollectionViewController ()

@end

@implementation CollectionViewController

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
//    musicFiles=[[NSArray alloc]initWithObjects:@"1.jpeg",@"2.jpeg",@"3.jpeg",@"4.jpeg", @"1.jpeg",@"2.jpeg",@"3.jpeg",@"4.jpeg",@"1.jpeg",@"2.jpeg",@"3.jpeg",@"4.jpeg",@"1.jpeg",@"2.jpeg",@"3.jpeg",@"4.jpeg",@"1.jpeg",@"2.jpeg",@"3.jpeg",@"4.jpeg",@"1.jpeg",@"2.jpeg",@"3.jpeg",@"4.jpeg",@"1.jpeg",@"2.jpeg",@"3.jpeg",@"4.jpeg",@"1.jpeg",@"2.jpeg",@"3.jpeg",@"4.jpeg",@"1.jpeg",@"2.jpeg",@"3.jpeg",@"4.jpeg",nil];
//
    NSLog(@"Loading Files ======");
    
    musicFiles=[[NSMutableArray<MPMediaItem *> alloc]init];
    
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
    NSFileManager *filemgr = [[NSFileManager alloc] init];
    
    NSArray *allFiles = [filemgr contentsOfDirectoryAtPath:bundlePath error:NULL];
    for (NSString *fileName in allFiles)
    {
        if ([[fileName pathExtension] isEqualToString:@"mp3"])
        {
            NSString *fullFilePath = [bundlePath stringByAppendingPathComponent:fileName];
            //do whatever you want to do with the path
           // [musicFiles addObject:song];
            NSLog(@"Got File -> %@", fullFilePath);
        }
    }
    
    
    MPMediaQuery *fullList = [MPMediaQuery songsQuery];
    //MPMediaQuery *fullList = [[MPMediaQuery alloc]init];
    //::.. lets go ..::
   
    NSArray *mediaList = [fullList items];
    int count = 0;
    for (MPMediaItem *song in mediaList) {
        NSString *songTitle = [song valueForProperty: MPMediaItemPropertyTitle];
        NSString *songArtist = [song valueForProperty: MPMediaItemPropertyArtist];
        count = count+1;
        [musicFiles addObject:song];
        NSLog (@"%d. %@ \"%@\"", count, songArtist, songTitle);
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return musicFiles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    MPMediaItem *musicFile = [musicFiles objectAtIndex:indexPath.row];
    
    UIImageView *imgView = (UIImageView *)[cell viewWithTag:100];
    
    MPMediaItemArtwork *artwork = [musicFile valueForKey:MPMediaItemPropertyArtwork];
    
    UIImage *image = [artwork imageWithSize:artwork.bounds.size];
    imgView.image = image;
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
    
       
        DetailViewController *controller = [segue destinationViewController];//(DetailViewController *)[[segue destinationViewController] topViewController];
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
