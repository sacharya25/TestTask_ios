//
//  ViewController.h
//  TestTask_iOS
//
//  Created by GRMINI-NEW-01 on 23/02/17.
//  Copyright © 2017 GRMINI-NEW-01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UITextFieldDelegate, UIAlertViewDelegate, UINavigationControllerDelegate>
{
    NSData *imgData;
    NSString *genderString;
    CGFloat viewY;
}
@property (weak, nonatomic) IBOutlet UITextField *txtFldName;
@property (weak, nonatomic) IBOutlet UITextField *txtFldEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtFldPhoneNo;
@property (weak, nonatomic) IBOutlet UITextField *txtFldDateOfBirth;
@property (weak, nonatomic) IBOutlet UIImageView *selectImg;
@property (weak, nonatomic) IBOutlet UIImageView *unSelectImg;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImg;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *viewForScroll;


@property (retain, nonatomic) NSMutableDictionary *dictionary;

- (IBAction)actionOnDateOfBirth:(id)sender;

-(IBAction)actionOnAddPhoto:(id)sender;
-(IBAction)actionOnSubmitBtn:(id)sender;
-(IBAction)actionOnFemaleSelect:(id)sender;
-(IBAction)actionOnMaleSelect:(id)sender;
-(IBAction)actionOnDoneBtn:(id)sender;
-(IBAction)actionOnCancelBtn:(id)sender;
@end
