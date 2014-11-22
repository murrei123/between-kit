//
//  I32ExchangeableTablesViewController.m
//  BetweenKit
//
//  Created by Stephen Fortune on 21/11/2014.
//  Copyright (c) 2014 stephen fortune. All rights reserved.
//

#import "I32ExchangeableTablesViewController.h"
#import <BetweenKit/I3GestureCoordinator.h>
#import <BetweenKit/I3BasicRenderDelegate.h>


static NSString* DequeueReusableCell = @"DequeueReusableCell";


@interface I32ExchangeableTablesViewController ()

@property (nonatomic, strong) I3GestureCoordinator *dragCoordinator;

@property (nonatomic, strong) NSMutableArray *leftData;

@property (nonatomic, strong) NSMutableArray *rightData;

@end


@implementation I32ExchangeableTablesViewController


-(void) viewDidLoad{
    
    [super viewDidLoad];
    
    
    /** Setup the table views with their data */

    self.leftData = [NSMutableArray arrayWithArray:@[@"1 Left", @"2 Left", @"3 Left", @"4 Left", @"5 Left"]];
    self.rightData = [NSMutableArray arrayWithArray:@[@"1 Right", @"2 Right", @"3 Right", @"4 Right", @"5 Right"]];
    
    [self.leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DequeueReusableCell];
    [self.rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DequeueReusableCell];
    
    
    /** Create the basic drag coordinator */
    
    self.dragCoordinator = [I3GestureCoordinator basicGestureCoordinatorFromViewController:self withCollections:@[self.leftTableView, self.rightTableView]];
    
}


-(void) didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    
}


#pragma mark - UITableViewDataSource, UITableViewDelegate


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
};


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
    return [(tableView == self.leftTableView ? self.leftData : self.rightData) count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:DequeueReusableCell forIndexPath:indexPath];
    NSInteger row = [indexPath row];
    NSArray *data = tableView == self.leftTableView ? self.leftData : self.rightData;
    
    cell.textLabel.text = [data objectAtIndex:row];
    
    return cell;
}


#pragma mark - I3DragDataSource


-(BOOL) canItemBeDraggedAtPoint:(CGPoint) at inCollection:(id<I3Collection>) collection{
    return YES;
}


-(BOOL) canItemAtPoint:(CGPoint)from fromCollection:(id<I3Collection>)fromCollection beExchangedWithItemAtPoint:(CGPoint)to inCollection:(id<I3Collection>)toCollection{
    return YES;
}


-(BOOL) hidesItemWhileDraggingAtPoint:(CGPoint) at inCollection:(id<I3Collection>) collection{
    return YES;
}


-(void) exchangeItemAtPoint:(CGPoint)from inCollection:(id<I3Collection>)fromCollection withItemAtPoint:(CGPoint)to inCollection:(id<I3Collection>)toCollection{
    
    
    UITableView *fromTable = (UITableView *)fromCollection.collectionView;
    UITableView *toTable = (UITableView *)toCollection.collectionView;
    
    NSIndexPath *toIndex = [toTable indexPathForRowAtPoint:to];
    NSIndexPath *fromIndex = [fromTable indexPathForRowAtPoint:from];
    
    
    /** Determine the `from` and `to` datasets */
    
    BOOL isFromLeftTable = fromTable == self.leftTableView;
    
    NSNumber *exchangingData = isFromLeftTable ? [self.leftData objectAtIndex:fromIndex.row] : [self.rightData objectAtIndex:fromIndex.row];
    NSMutableArray *fromDataset = isFromLeftTable ? self.leftData : self.rightData;
    NSMutableArray *toDataset = isFromLeftTable ? self.rightData : self.leftData;
    
    
    /** Update the data source and the individual table view rows */
    
    [fromDataset removeObjectAtIndex:fromIndex.row];
    [toDataset insertObject:exchangingData atIndex:toIndex.row];
    
    [fromTable deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:fromIndex.row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [toTable insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:toIndex.row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    
}


@end
