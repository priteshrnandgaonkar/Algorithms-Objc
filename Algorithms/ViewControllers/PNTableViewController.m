//
//  PNTableViewController.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/29/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "PNTableViewController.h"
#import "PNTableViewCell.h"

@interface PNTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation PNTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tappedAct:(UIButton *)sender {
    Log(@"Tapped Act");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifier];
    cell.cellNum.text = @(indexPath.item).stringValue;
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
