//
//  ViewController.m
//  TestTask_iOS
//
//  Created by GRMINI-NEW-01 on 23/02/17.
//  Copyright © 2017 GRMINI-NEW-01. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SignUp";
    self.dictionary = [[NSMutableDictionary alloc] init];
    [self setUpDataInView];
    // Do any additional setup after loading the view.
}

- (void)setUpDataInView {
    self.profilePicImg.layer.backgroundColor=[[UIColor clearColor] CGColor];
    self.profilePicImg.layer.cornerRadius=self.profilePicImg.frame.size.height/2;
    self.profilePicImg.layer.masksToBounds = YES;
    self.profilePicImg.layer.borderColor=[[UIColor redColor] CGColor];
    [self.pickerView setHidden:YES];
    self.datePicker = [[UIDatePicker alloc]init];
    [self.datePicker setDate:[NSDate date]];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.backgroundColor = [UIColor clearColor];
    [self.datePicker addTarget:self action:@selector(dateSelect:) forControlEvents:UIControlEventValueChanged];
    [self.txtFldDateOfBirth setInputView:self.datePicker];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    genderString = @"male";
    viewY = self.viewForScroll.frame.origin.y;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    DetailViewController *detailObj = [segue destinationViewController];
    detailObj.imgData = imgData;
    detailObj.detailDictionary = self.dictionary;
    
    // Pass the selected object to the new view controller.
}

#pragma mark- Button Actions

-(IBAction)actionOnSubmitBtn:(id)sender {
    if ([self.txtFldName.text isEqualToString:@""]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter UserName" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if ([self.txtFldEmail.text isEqualToString:@""])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter Email" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];

    } else if (![self NSStringIsValidEmail:self.txtFldEmail.text]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter valid Email" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        [self.dictionary setObject:self.txtFldName.text forKey:@"name"];
        [self.dictionary setObject:self.txtFldEmail.text forKey:@"email"];
        [self.dictionary setObject:self.txtFldPhoneNo.text forKey:@"phoneNo"];
        [self.dictionary setObject:self.txtFldDateOfBirth.text forKey:@"dateOfBirth"];
        [self.dictionary setObject:genderString forKey:@"gender"];
        [self performSegueWithIdentifier:@"Detail" sender:nil];
    }
}

-(IBAction)actionOnFemaleSelect:(id)sender {
    genderString = @"female";
    [self.selectImg setImage:[UIImage imageNamed:@"unselected.png"]];
    [self.unSelectImg setImage:[UIImage imageNamed:@"selected_icon.png"]];
}

-(IBAction)actionOnMaleSelect:(id)sender {
    genderString = @"male";
    [self.selectImg setImage:[UIImage imageNamed:@"selected_icon.png"]];
    [self.unSelectImg setImage:[UIImage imageNamed:@"unselected.png"]];
}

- (IBAction)actionOnDateOfBirth:(id)sender {
    [self.pickerView setHidden:NO];
    [self.datePicker setHidden:NO];
    [UIView animateWithDuration:0.25 animations:^{
        self.viewForScroll.frame =  CGRectMake(0, self.viewForScroll.frame.origin.y-50, self.viewForScroll.frame.size.width, self.viewForScroll.frame.size.height);
    }];

}

-(IBAction)actionOnAddPhoto:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Attach image" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* pickFromGallery = [UIAlertAction actionWithTitle:@"Take a photo"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {
                                                                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                                                                {
                                                                    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
                                                                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                                    picker.delegate = self;
                                                                    [self presentViewController:picker animated:YES completion:NULL];
                                                                }
                                                                
                                                            }];
    UIAlertAction* takeAPicture = [UIAlertAction actionWithTitle:@"Choose from gallery"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             UIImagePickerController* picker = [[UIImagePickerController alloc] init];
                                                             picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                             picker.delegate = self;
                                                             [self presentViewController:picker animated:YES completion:NULL];
                                                         }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * action) {
                                                   }];

    [alertController addAction:pickFromGallery];
    [alertController addAction:takeAPicture];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(IBAction)actionOnDoneBtn:(id)sender {
    self.txtFldDateOfBirth.text = [self formatDate:self.datePicker.date];
    [self.pickerView setHidden:YES];
    [self.datePicker setHidden:YES];
    [self.datePicker removeFromSuperview];
}

-(IBAction)actionOnCancelBtn:(id)sender {
    [self.pickerView setHidden:YES];
    [self.datePicker setHidden:YES];
    [self.datePicker removeFromSuperview];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *imagePicked = info[UIImagePickerControllerOriginalImage];
    [self.profilePicImg setImage:imagePicked];
    imgData = UIImagePNGRepresentation(imagePicked);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - TextField Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.txtFldName) {
        [self.txtFldEmail becomeFirstResponder];
    } else if (textField == self.txtFldEmail) {
        [self.txtFldPhoneNo becomeFirstResponder];
    } else if (textField == self.txtFldPhoneNo) {
        [self.txtFldDateOfBirth becomeFirstResponder];
    } else if (textField == self.txtFldDateOfBirth) {
        [self.txtFldDateOfBirth resignFirstResponder];
    }

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.txtFldPhoneNo)
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.viewForScroll.frame =  CGRectMake(0, self.viewForScroll.frame.origin.y-50, self.viewForScroll.frame.size.width, self.viewForScroll.frame.size.height);
        }];
    } else if (textField == self.txtFldDateOfBirth) {
        [UIView animateWithDuration:0.25 animations:^{
            self.viewForScroll.frame =  CGRectMake(0, self.viewForScroll.frame.origin.y-50, self.viewForScroll.frame.size.width, self.viewForScroll.frame.size.height);
        }];

        [self.pickerView setHidden:NO];
        [self.datePicker setHidden:NO];
    }
}
- (IBAction)dateSelect:(id)sender {
    self.txtFldDateOfBirth.text = [self formatDate:self.datePicker.date];
    [self.pickerView setHidden:YES];
    [self.datePicker setHidden:YES];
    [self.datePicker removeFromSuperview];
    [UIView animateWithDuration:0.25 animations:^{
        self.viewForScroll.frame =  CGRectMake(0, viewY, self.viewForScroll.frame.size.width, self.viewForScroll.frame.size.height);
    }];
}

- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"MM'/'dd'/'yyyy"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(void)dismissKeyboard
{
    [self hidekeyboardAllTextfield];
}


-(void)hidekeyboardAllTextfield {
    [UIView animateWithDuration:0.25 animations:^{
        self.viewForScroll.frame =  CGRectMake(0, viewY, self.viewForScroll.frame.size.width, self.viewForScroll.frame.size.height);
    }];
    [self.txtFldName resignFirstResponder];
    [self.txtFldEmail resignFirstResponder];
    [self.txtFldPhoneNo resignFirstResponder];
    [self.txtFldDateOfBirth resignFirstResponder];
    [self.pickerView setHidden:YES];
    [self.datePicker setHidden:YES];
    [self.datePicker removeFromSuperview];
}

@end
