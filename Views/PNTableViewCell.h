//
//  PNTableViewCell.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/29/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const kReusableIdentifier = @"reusableId";

@interface PNTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellNum;

@end
