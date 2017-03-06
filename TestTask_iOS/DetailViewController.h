//
//  DetailViewController.h
//  TestTask_iOS
//
//  Created by GRMINI-NEW-01 on 23/02/17.
//  Copyright © 2017 GRMINI-NEW-01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (retain, nonatomic) NSMutableDictionary *detailDictionary;

@property (retain, nonatomic) NSData *imgData;

@property (weak, nonatomic) IBOutlet UIImageView *profilePicImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirthLbl;
@property (weak, nonatomic) IBOutlet UILabel *genderLbl;



@end
