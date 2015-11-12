//
//  ImagesTableViewController.m
//  Blocstagram
//
//  Created by Carlos Calderon on 11/4/15.
//  Copyright (c) 2015 Carlos Calderon. All rights reserved.
//

#import "ImagesTableViewController.h"
#import "DataSource.h"
#import "Media.h"
#import "User.h"
#import "Comment.h"
#import "MediaTableViewCell.h"

@interface ImagesTableViewController ()

@end

@implementation ImagesTableViewController

-(id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if(self){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[DataSource sharedInstance] addObserver:self forKeyPath:@"mediaItems" options:0 context:nil];
    
    [self.tableView registerClass:[MediaTableViewCell class] forCellReuseIdentifier:@"mediaCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [DataSource sharedInstance].mediaItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MediaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mediaCell" forIndexPath:indexPath];
    cell.mediaItem = [DataSource sharedInstance].mediaItems[indexPath.row];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Media *item = [DataSource sharedInstance].mediaItems[indexPath.row];
    return [MediaTableViewCell heightForMediaItem:item width:CGRectGetWidth(self.view.frame)];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if(object == [DataSource sharedInstance] && [keyPath isEqualToString:@"mediaItems"]){
        //media items chnaged . Let's see what kind of change it it
        NSKeyValueChange kindOfChange = [change[NSKeyValueChangeKindKey] unsignedIntegerValue];
        
        if(kindOfChange == NSKeyValueChangeSetting){
            //new image array was set
            [self.tableView reloadData];
        } else if (kindOfChange == NSKeyValueChangeInsertion ||
                   kindOfChange == NSKeyValueChangeRemoval ||
                   kindOfChange == NSKeyValueChangeReplacement){
            //incremental change: inserted, deleted replaced
            
            //Get a list of the Index/indexes that changed
            NSIndexSet *indexSetOfChanges = change[NSKeyValueChangeIndexesKey];
            
            //Convert NSIndexSet to NSArray of NSIndexPaths (able view animation needs that)
            NSMutableArray *indexPathsThatChanged = [NSMutableArray array];
            [indexSetOfChanges enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:idx inSection:0];
                [indexPathsThatChanged addObject:newIndexPath];
            }];
            
            //begin Updates to tel the table view we're about to make chnages
            [self.tableView beginUpdates];
            
            //tell table view about the changes
            if(kindOfChange == NSKeyValueChangeInsertion){
                [self.tableView insertRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (kindOfChange == NSKeyValueChangeRemoval){
                [self.tableView deleteRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (kindOfChange == NSKeyValueChangeReplacement){
                [self.tableView reloadRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
            //tell table we're done with changes
            [self.tableView endUpdates];
        }
     }
}

- (void) dealloc {
    [[DataSource sharedInstance] removeObserver:self forKeyPath:@"mediaItems"];
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
}

 //Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteme = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@" Delete me " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                  {
                                      Media *item = [DataSource sharedInstance].mediaItems[indexPath.row];
                                      [[DataSource sharedInstance] deleteMediaItem:item];
                                  }];
    deleteme.backgroundColor = [UIColor colorWithRed:1.00 green:0.00 blue:0.00 alpha:1.0];
    
    UITableViewRowAction *top = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@" Top me " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                  {
                                      Media *item = [DataSource sharedInstance].mediaItems[indexPath.row];
                                      [[DataSource sharedInstance] moveMediaItemToTop:item];
                                  }];
    top.backgroundColor = [UIColor colorWithRed:0.62 green:0.49 blue:0.86 alpha:1.0];
    
    UITableViewRowAction *swapWithTop = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@" Swap with top " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                  {
                                      Media *item = [DataSource sharedInstance].mediaItems[indexPath.row];
                                      [[DataSource sharedInstance] swapMediaItemWithTop:item];
                                  }];
    swapWithTop.backgroundColor = [UIColor colorWithRed:0.27 green:0.81 blue:0.60 alpha:1.0];
    
    NSArray *buttons;
    if(indexPath.row > 0){
        buttons = @[top, swapWithTop, deleteme];
    } else {
        buttons = @[deleteme];
    }
    
    return buttons;
}



// Override to support editing the table view.


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


//// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewCellEditingStyleNone;
//}
//
//- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
//    return NO;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before 
 navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
