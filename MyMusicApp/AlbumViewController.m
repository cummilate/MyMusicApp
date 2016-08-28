//
//  AlbumViewController.m
//  MyMusicApp
//
//  Created by Niranjan on 28/08/16.
//  Copyright © 2016 PeersTech. All rights reserved.
//

#import "AlbumViewController.h"
#import "SongViewController.h"
@interface AlbumViewController ()

@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _myTable.dataSource = self;
    _myTable.delegate = self;
    
    MPMediaQuery *allAlbumsQuery = [MPMediaQuery albumsQuery];
    allAlbumsArray = [allAlbumsQuery collections];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allAlbumsArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *albumArtworkImage = nil;
    
    MPMediaItemCollection *collection  = allAlbumsArray[indexPath.row];
    
   
        MPMediaItem *item = [collection representativeItem];
        
        MPMediaItemArtwork *artwork = [item valueForKey:MPMediaItemPropertyArtwork];
        
        if (artwork != nil) {
            albumArtworkImage = [artwork imageWithSize:CGSizeMake(45,45)];
        }
    
  
    if (albumArtworkImage == nil) {
        albumArtworkImage = [UIImage imageNamed:@"defaultAlbumArtwork"];
    }
    
    static NSString *identifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.textLabel.text =  [item valueForKey:MPMediaItemPropertyAlbumTitle];
    cell.imageView.image = albumArtworkImage;
    cell.detailTextLabel.text =  [NSString stringWithFormat:@"%d songs",[collection  count]] ;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = self.myTable.indexPathsForSelectedRows.firstObject;
        
        
        SongViewController *controller = [segue destinationViewController];//(DetailViewController *)[[segue destinationViewController] topViewController];
        controller.mediaItemCollection  = [allAlbumsArray objectAtIndex:indexPath.row];
        // controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        // controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}


@end
