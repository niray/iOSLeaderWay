//
//  BNRItemsViewController.m
//  LeaningWay
//
//  Created by Huway Mac on 16/5/18.
//  Copyright © 2016年 Android Develope. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRDetailVC.h"

@interface BNRItemsViewController ()
@property (nonatomic,strong) IBOutlet UIView *headerView;
@end
@implementation BNRItemsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    UIView *header= self.headerView;
    [self.tableView setTableHeaderView:header];
}

-(instancetype)init{
    self=[super initWithStyle:UITableViewStylePlain];
    
    UINavigationItem *navItem =  self.navigationItem  ;
    navItem.title=@"ItemVC";
    
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
    navItem .rightBarButtonItem = bbi;
    navItem.leftBarButtonItem = self.editButtonItem;
    
    
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self addNewItem:nil];
    [self addNewItem:nil];
    [self addNewItem:nil];
}

-(instancetype)initWithStyle:(UITableViewStyle)style{
    return [self init];
}


//-(UIView *)headerView{
//    if(!_headerView){
//       _headerView =  [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil][0];
//    }
//    return _headerView;
//}
//
//-(IBAction)toggleEditingMode:(id)sender{
//    if(self.isEditing) {
//        [sender setTitle:@"Edit" forState:UIControlStateNormal];
//        [self setEditing:NO animated:YES];
//    }else{
//        [sender setTitle:@"Done" forState:UIControlStateNormal];
//        [self setEditing:YES animated:YES];
//    }
//}

-(IBAction)addNewItem:(id)sender{
    //NSInteger lastRow = [self.tableView numberOfRowsInSection:0] ;
    BNRItem *newItem = [[BNRItemStore sharedStore]createItem];
    NSInteger lastRow = [[[BNRItemStore sharedStore]allItems]indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSArray *items = [[BNRItemStore sharedStore]allItems];
        BNRItem *item = items[indexPath.row];
        [[BNRItemStore sharedStore] removeItem:item];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Wanted";
}

-(void) viewWillAppear:(BOOL)animated   {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[BNRItemStore sharedStore]allItems]count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [ tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath :indexPath];
   NSArray *items = [[BNRItemStore sharedStore]allItems];
   BNRItem *item = items[indexPath.row];
   cell.textLabel.text = [item description] ;
  //cell.textLabel.text = [NSString stringWithFormat:@"secetion:%d,row:%d",indexPath.section,indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath{
    NSLog([NSString stringWithFormat:@"from %d to %d",sourceIndexPath.row,destinationIndexPath.row]);
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BNRDetailVC *detailVC = [[BNRDetailVC alloc]init];
    NSArray *items = [[BNRItemStore sharedStore]allItems];
    detailVC.item  = items[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
