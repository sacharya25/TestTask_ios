//
//  DetailViewController.m
//  TestTask_iOS
//
//  Created by GRMINI-NEW-01 on 23/02/17.
//  Copyright © 2017 GRMINI-NEW-01. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize detailDictionary, imgData;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Details";
    [self setDataInView];
    // Do any additional setup after loading the view.
}

- (void)setDataInView {
    self.profilePicImg.layer.backgroundColor=[[UIColor clearColor] CGColor];
    self.profilePicImg.layer.cornerRadius=self.profilePicImg.frame.size.height/2;
    self.profilePicImg.layer.masksToBounds = YES;
    self.profilePicImg.layer.borderColor=[[UIColor redColor] CGColor];
    self.nameLbl.text = [self.detailDictionary objectForKey:@"name"];
    self.emailLbl.text = [self.detailDictionary objectForKey:@"email"];
    self.genderLbl.text = [self.detailDictionary objectForKey:@"gender"];
    if ([[self.detailDictionary objectForKey:@"phoneNo"] isEqualToString:@""]) {
        self.phoneLbl.text = @"N/A";
    } else {
        self.phoneLbl.text = [self.detailDictionary objectForKey:@"phoneNo"];
    }
    if ([[self.detailDictionary objectForKey:@"dateOfBirth"] isEqualToString:@""]) {
        self.dateOfBirthLbl.text = @"N/A";
    } else {
        self.dateOfBirthLbl.text = [self.detailDictionary objectForKey:@"dateOfBirth"];
    }
    if (self.imgData == nil) {

    } else
        self.profilePicImg.image = [UIImage imageWithData:self.imgData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
