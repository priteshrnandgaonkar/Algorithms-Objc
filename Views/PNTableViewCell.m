//
//  PNTableViewCell.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/29/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "PNTableViewCell.h"
#import "PNTableViewController.h"

@implementation PNTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)tappedAct:(UIButton *)sender {
    
    Log(@"Tapped ct first catch");
//    [self doesNotRecognizeSelector:@selector(tappedAct:)];
    
    UIResponder *responder = self.nextResponder;
    while (responder) {
        responder = responder.nextResponder;
        if([responder isKindOfClass:[PNTableViewController class]]) {
            [(PNTableViewController *)responder tappedAct:sender];
            break;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
