//
//  EditProfileVC.m
//  RP
//
//  Created by Mac on 09/09/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "EditProfileVC.h"
#import "RPConstants.h"
#import "AppManager.h"
#import "IQActionSheetPickerView.h"

@interface EditProfileVC ()<UITextFieldDelegate, IQActionSheetPickerViewDelegate>

{
    UITextField *activeTextfield;
}

@property (assign) genderType userGenderType;
@end

@implementation EditProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createCustomizeUI];
    [self setupDataForTextFields];
    self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width, self.view.frame.size.height+ 350);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}


#pragma mark - Set Up Initial Data

-(void)setupDataForTextFields
{

    if (_user.FirstName)
        _txtName.text = _user.FirstName;
    else
        _txtName.text = @"";
    
    if (_user.Phone)
        _txtPhoneNo.text = _user.Phone;
    else
        _txtPhoneNo.text = @"";
    
    if (_user.Height)
    {
        NSString *height = [NSString stringWithFormat:@"%.2f", [_user.Height floatValue]];
        _txtHeight.text = height;
    }
    else
        _txtHeight.text = @"";
    
    if (_user.Weight )
    {
        NSString *weight = [NSString stringWithFormat:@"%.2f", [_user.Weight floatValue]];
        _txtWeight.text = weight;
    }
    else
        _txtWeight.text = @"";
    
    if (_user.Age)
    {
        NSString *age = [NSString stringWithFormat:@"%d", [_user.Age intValue]];
        _txtAge.text = age;
    }
    else
        _txtAge.text = @"";
    
    if (_user.City)
        _txtCity.text = _user.City;
    else
        _txtCity.text = @"";
    
    if (_user.AboutMe)
        _txtAboutMe.text = _user.AboutMe;
    else
        _txtAboutMe.text = @"";
    
    //setup the gender values from Initial User Data
    self.userGenderType = [self.user.Gender intValue];
    [self.imgVwMale setImage:[UIImage imageNamed:@"circleblack.png"]];
    [self.imgVwFemale setImage:[UIImage imageNamed:@"circleblack.png"]];
    [self.imgVwOther setImage:[UIImage imageNamed:@"circleblack.png"]];
    
    if (self.userGenderType == userGenderTypeFemale) {
        [self.imgVwFemale setImage:[UIImage imageNamed:@"circlegreen.png"]];
    }
    else if (self.userGenderType == userGenderTypeMale) {
        [self.imgVwMale setImage:[UIImage imageNamed:@"circlegreen.png"]];
    }
    else if (self.userGenderType == userGenderTypeOther) {
        [self.imgVwOther setImage:[UIImage imageNamed:@"circlegreen.png"]];
    }
}


#pragma mark - Customize UI

-(void)createCustomizeUI
{
    if (self.isPresentModal) {
        self.btnback.hidden = YES;
        self.btnClose.hidden = NO;
        CGRect frame = self.imgVwBG.frame;
        frame.size.height += 40;
        self.imgVwBG.frame = frame;
        
        CGRect frame1 = self.scroll.frame;
        frame1.size.height += 40;
        self.scroll.frame = frame1;
    }
    
    self.vwheader.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
    self.lblHeader.text = @"Edit Profile";
//    self.lblHeader.font = TOP_BAR_TITLE_FONT;
    self.lblHeader.textColor = TOP_BAR_TEXT_COLOR;
    
    //textfields
    [self customizeTextField:_txtName];
    [self.txtName setPlaceholder:@"Name"];

    [self customizeTextField:_txtPhoneNo];
    [self.txtPhoneNo setPlaceholder:@"Phone"];
    _txtPhoneNo.inputAccessoryView = [self customizeAccessoryView];

    [self customizeTextField:_txtCity];
    [self.txtCity setPlaceholder:@"City"];
    
//    [self customizeTextField:_txtGender];
//    [self.txtGender setPlaceholder:@"Gender"];
    
    [self customizeTextField:_txtHeight];
    [self.txtHeight setPlaceholder:@"Height (in Feets)"];
    _txtHeight.inputAccessoryView = [self customizeAccessoryView];

    [self customizeTextField:_txtWeight];
    [self.txtWeight setPlaceholder:@"Weight (in Kg)"];
    _txtWeight.inputAccessoryView = [self customizeAccessoryView];

    [self customizeTextField:_txtAge];
    [self.txtAge setPlaceholder:@"Age"];
    _txtAge.inputAccessoryView = [self customizeAccessoryView];

    [self customizeTextField:_txtAboutMe];
    [self.txtAboutMe setPlaceholder:@"About Me"];

    
    //=================For Gender Selection======================

    self.lblGender.textColor = TEXT_FIELD_INPUT_COLOR;
    self.lblGender.font = APP_BUTTON_TITLE_FONT;

    self.btnMale.backgroundColor = [UIColor clearColor];
    self.btnMale.tag = 1;
    [self.btnMale setTitleColor:TEXT_FIELD_INPUT_COLOR forState:UIControlStateNormal];
//    self.btnMale.titleLabel.font = APP_BUTTON_TITLE_FONT_MEDIUM;
    [self.btnMale setTitle:@"Male" forState:UIControlStateNormal];
    
    self.btnFemale.backgroundColor = [UIColor clearColor];
    self.btnFemale.tag = 2;
    [self.btnFemale setTitleColor:TEXT_FIELD_INPUT_COLOR forState:UIControlStateNormal];
//    self.btnFemale.titleLabel.font = APP_BUTTON_TITLE_FONT_MEDIUM;
    [self.btnFemale setTitle:@"Female" forState:UIControlStateNormal];
    
    self.btnOther.backgroundColor = [UIColor clearColor];
    self.btnOther.tag = 3;
    [self.btnOther setTitleColor:TEXT_FIELD_INPUT_COLOR forState:UIControlStateNormal];
//    self.btnOther.titleLabel.font = APP_BUTTON_TITLE_FONT_MEDIUM;
    [self.btnOther setTitle:@"Other" forState:UIControlStateNormal];
    
    
    [self.imgVwMale setImage:[UIImage imageNamed:@"circleblack.png"]];
    [self.imgVwFemale setImage:[UIImage imageNamed:@"circleblack.png"]];
    [self.imgVwOther setImage:[UIImage imageNamed:@"circleblack.png"]];

    //vuttons
    _btnUpdateData.backgroundColor = APP_BUTTON_BACKGROUND_COLOR;
    _btnUpdateData.titleLabel.textColor =  APP_BUTTON_TEXT_COLOR;
//    _btnUpdateData.titleLabel.font = APP_BUTTON_TITLE_FONT_MEDIUM;
    [_btnUpdateData setTitle:@"UPDATE" forState:UIControlStateNormal];
    _btnUpdateData.tintColor = APP_BUTTON_TEXT_COLOR;

}


-(void)customizeTextField:(UITextField *)textField
{
//    textField.font = APPLICATION_TEXTFIELD_FONT;
    
    [self setupPaddingView:textField];
    [self setPlaceHolderColor:textField];
}

-(UIToolbar *)customizeAccessoryView
{
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    buttonDone.tintColor = TOP_BAR_BACKGROUND_COLOR;
    
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    [toolbar sizeToFit];

    return toolbar;
}

-(void)doneClicked:(id)sender
{
    [self.view endEditing:YES];
}

-(void)setupPaddingView:(UITextField *)textField
{
    UIView *leftView = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, 8, 20)];
    leftView.backgroundColor = [UIColor clearColor];
    if (!textField.leftView) {
        textField.leftView = leftView;
    }
    textField.leftViewMode = UITextFieldViewModeAlways;
}

-(void)addBottomBorderForView:(UIView *)Vw withcolor:(UIColor *)color andHeight:(CGFloat)height
{
    NSArray *layers = [Vw.layer sublayers];
    for (CALayer *layer in layers) {
        if ([layer.accessibilityHint isEqualToString:@"101"]) {
            [layer setFrame:CGRectMake(0.0f, Vw.frame.size.height-height, Vw.frame.size.width, height)];
            layer.backgroundColor = color.CGColor;
            return;
        }
    }
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.accessibilityHint = @"101";
    bottomBorder.frame = CGRectMake(0.0f, Vw.frame.size.height-height, Vw.frame.size.width, height);
    bottomBorder.backgroundColor = color.CGColor;
    [Vw.layer addSublayer:bottomBorder];
}

-(void)setPlaceHolderColor:(UITextField*)txtField
{
    if ([txtField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        txtField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:txtField.placeholder attributes:@{NSForegroundColorAttributeName: TEXT_FIELD_PLACEHOLDER_COLOR}];
        txtField.tintColor = TEXT_FIELD_INPUT_COLOR;
    }
}

#pragma mark - TextField Delegate Methods

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self addBottomBorderForView:textField withcolor:TEXT_FIELD_PLACEHOLDER_COLOR andHeight:1];

    if (textField == _txtName){
        activeTextfield = textField;
        [self animateScrollOffsetwithYpos:0 andHeight:480];
    }
    else if (textField == _txtPhoneNo){
        activeTextfield = textField;
        [self animateScrollOffsetwithYpos:60 andHeight:480];
    }
    else if (textField == _txtCity){
        activeTextfield = textField;
        [self animateScrollOffsetwithYpos:120 andHeight:480];
    }
    else if (textField == _txtAge){
        activeTextfield = textField;
        [self animateScrollOffsetwithYpos:300 andHeight:480];
    }
    else if (textField == _txtHeight){
        activeTextfield = textField;
        [self animateScrollOffsetwithYpos:360 andHeight:480];
    }
    else if (textField == _txtWeight){
        activeTextfield = textField;
        [self animateScrollOffsetwithYpos:420 andHeight:480];
    }
    else if (textField == _txtAboutMe){
        activeTextfield = textField;
        [self animateScrollOffsetwithYpos:480 andHeight:480];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self addBottomBorderForView:textField withcolor:TEXT_FIELD_PLACEHOLDER_COLOR andHeight:0];
    [self animateScrollOffsetwithYpos:0 andHeight:350];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

#pragma mark - Helpers

//Helpers Animation of scroll

-(void)animateScrollOffsetwithYpos:(CGFloat)Ypos andHeight:(CGFloat)height
{
    CGPoint offset = self.scroll.contentOffset;
    offset.y = Ypos;
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self.scroll setContentOffset:offset];
                     }
                     completion:^(BOOL finished){
                     }];
    
    self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width, self.view.frame.size.height+ height);
}

-(void)pickDatewithTag:(NSInteger)tag andTitle:(NSString *)title andType:(IQActionSheetPickerStyle)style
{
    [self.view endEditing:YES];
    //config picker.
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:title delegate:self];
    NSArray *arrList= @[@"FEMALE", @"MALE", @"OTHER", @"NONE"];
    [picker setTitlesForComponents:@[arrList]];
    picker.tintColor = [UIColor colorWithWhite:0.4f alpha:0.9f ]; //for cancel & done button color
    picker.titleColor = [UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1.0];
    picker.titleFont = [UIFont fontWithName:@"Arial" size:16];
    //    [picker setTitle:title];
    picker.delegate = self;
    picker.tag = tag;
    /*
     // set minimum value for date picker
     [picker setMinimumDate:[NSDate date]];
     */
    [picker setActionSheetPickerStyle:style];
    [picker show];
    
}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles
{
    NSLog(@"Titles :%@", titles);
//    self.btnGender.accessibilityIdentifier = [titles lastObject];
//    [self.btnGender setTitle:[titles lastObject] forState:UIControlStateNormal];
}

#pragma mark - Click Events

-(IBAction)clickedGender:(UIButton*)sender
{
    [self.imgVwMale setImage:[UIImage imageNamed:@"circleblack.png"]];
    [self.imgVwFemale setImage:[UIImage imageNamed:@"circleblack.png"]];
    [self.imgVwOther setImage:[UIImage imageNamed:@"circleblack.png"]];
    
    switch (sender.tag) {
        case 1:
            [self.imgVwMale setImage:[UIImage imageNamed:@"circlegreen.png"]];
            self.userGenderType = userGenderTypeMale;
            break;
        case 2:
            [self.imgVwFemale setImage:[UIImage imageNamed:@"circlegreen.png"]];
            self.userGenderType = userGenderTypeFemale;
            break;
        case 3:
            [self.imgVwOther setImage:[UIImage imageNamed:@"circlegreen.png"]];
            self.userGenderType = userGenderTypeOther;
            break;
        default:
            break;
    }
    
}

/*
-(IBAction)clickedGender:(id)sender
{
    [self pickDatewithTag:1 andTitle:@"Select Your Gender" andType:IQActionSheetPickerStyleTextPicker];
}
*/

-(IBAction)clickedSaveData:(id)sender
{
    RPLog(@"User Profile Update  Data");
    if ([self validateUserProfileData]) {
        [self updateUserDataForNetworkCall];
//        [self connectionUpdateUser];
        [self connectionUpdateUser];
    }
}


-(IBAction)clickedBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)clickedClose:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Validate Profile Data
-(BOOL) validateUserProfileData
{
    BOOL isValid = YES;
    NSString *strMsg = @"";
    if (!(_txtName.text.length > 0)) {
        isValid = NO;
        strMsg = @"Please Enter Your Name.";
        //        [self customizeTextFieldForError:_txtEmail];
    }
    else if (!(_txtAboutMe.text.length > 0)) {
        isValid = NO;
        strMsg = @"Please Some Description About Yourself.";
        //        [self customizeTextFieldForError:_txtpassword];
    }
    
    if (self.userGenderType != userGenderTypeFemale && self.userGenderType != userGenderTypeMale && self.userGenderType != userGenderTypeOther) {
        strMsg = @"You will not get your desired result if skip Gender field.";
    }
    if ( _txtAge.text.length <= 0 ) {
        strMsg = @"You will not get your desired result if skip Age field.";
    }
    if ( _txtHeight.text.length <= 0 ) {
        strMsg = @"You will not get your desired result if skip Height field.";
    }
    if ( _txtWeight.text.length <= 0 ) {
        strMsg = @"You will not get your desired result if skip Weight field.";
    }
    if (strMsg.length > 0) {
        [[AppManager sharedDataAccess] showAlertWithTitle:@"Alert!" andMessage:strMsg fromViewController:self];
    }

    return isValid;
    
}

-(void)updateUserDataForNetworkCall
{
    self.user.FirstName = _txtName.text;
    self.user.Phone = _txtPhoneNo.text;
    self.user.Height =[NSNumber numberWithFloat:[_txtHeight.text floatValue]];
    self.user.Weight =[NSNumber numberWithFloat:[_txtWeight.text floatValue]];
    self.user.Age =[NSNumber numberWithInt:[_txtAge.text intValue]];
    self.user.City = _txtCity.text;
    self.user.AboutMe = _txtAboutMe.text;
    
//    genderType userGenderType = [[AppManager sharedDataAccess]  getUserGenderTypeWithText:self.btnGender.accessibilityIdentifier];
    _user.Gender = [NSNumber numberWithInteger:self.userGenderType];
    
}

#pragma mark - Webservice

-(void)connectionUpdateUser
{
    NSDictionary *dictParam = [self.user dictionaryReflectFromAttributes];
    
    NSString *requestTypeMethod =   [[AppManager sharedDataAccess]  getStringForRequestType: PUT];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[RPNetworkManager defaultNetworkManager] RPServicewithMethodName:UPDATE_USER_PATH withParameters:dictParam andRequestType:requestTypeMethod success:^(id response) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSDictionary *dictData;
        if ([response isKindOfClass:[NSDictionary class]]) {
            dictData = response;
        }
        if ([[dictData objectForKey:@"ErrorCode"]  intValue] == 200 ) {
            
            [self showAlertWithTitle:@"Success" andMessage:@"Your Profile has been succesfully updated." fromViewController:self];
        }
        else
        {
            [[AppManager sharedDataAccess] showAlertWithTitle:@"Warning!" andMessage:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"ErrorMessage"]] fromViewController:self];
        }
    } failure:^(id failureMessage, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        RPLog(@"Error : %@", error.localizedDescription);
    }];
    
}

-(void)getUserProfileWithDictionary:(NSDictionary *)dictData
{
    DCParserConfiguration *config = [DCParserConfiguration configuration];
    DCObjectMapping *mapper = [DCObjectMapping mapKeyPath:@"Id" toAttribute:@"userID" onClass:[RunnerUser class]];
    [config addObjectMapping:mapper];
    
    
    DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass: [RunnerUser class] andConfiguration:config];
    RunnerUser *user = [parser parseDictionary:[dictData objectForKey:@"Result"]];
    
    if (user) {
        RPLog(@"Get User Result : %@", user.description);
        [AppManager sharedDataAccess].user = user;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    [super viewWillDisappear:YES];
}


-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message fromViewController:(UIViewController *)vc{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       [self.navigationController popViewControllerAnimated:YES];
                                   }];
    
    
    [alertController addAction:cancelAction];
    alertController.view.tintColor = [UIColor redColor];
    [vc presentViewController: alertController animated:YES completion:nil];
    
}


/*
#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 30.0f;
    }
    else
        return 0.0f;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView;
    if (section == 1) {
        headerView = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, _tableEditProfile.frame.size.width, 30)];
        headerView.backgroundColor = [UIColor whiteColor];
        return headerView;
    }
    else
        return nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 50.0f;
    }
    else
        return 80.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return arrPlaceHolder.count;
    }
    else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier1 = @"editField";
    static NSString *cellIdentifier2 = @"updateData";
    
    if (indexPath.section == 0) {
        userEditProfileCell *editCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1 forIndexPath:indexPath];

        editCell.backgroundColor = [UIColor clearColor];
        editCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [editCell setCellUIforTxtField];
        editCell.textField.delegate = self;
        [self configContactCell:editCell withIndex:indexPath.row];
        return editCell;
        
    }
    else if (indexPath.section == 1) {
        UITableViewCell *saveCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2 forIndexPath:indexPath];
        saveCell.backgroundColor = [UIColor clearColor];
        saveCell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *btnSave = (UIButton *) [saveCell.contentView viewWithTag:1];
        [self configUIForButton:btnSave];
        [btnSave addTarget:self action:@selector(clickedSaveData) forControlEvents:UIControlEventTouchUpInside];
        return saveCell;
    }
    
    return nil;
}

#pragma mark - Config UI & Data For Table VIew - Helpers

-(void)configUIForButton:(UIButton *)button
{
    button.backgroundColor = APP_BUTTON_BACKGROUND_COLOR;
    button.titleLabel.textColor =  APP_BUTTON_TEXT_COLOR;
    button.titleLabel.font = APP_BUTTON_TITLE_FONT;
    [button setTitle:@"UPDATE" forState:UIControlStateNormal];
    button.tintColor = APP_BUTTON_TEXT_COLOR;
}

-(void)configContactCell:(userEditProfileCell *)cell withIndex:(NSInteger )index
{
    cell.lblTag.text = [arrPlaceHolder objectAtIndex:index];
    cell.textField.placeholder = [arrPlaceHolder objectAtIndex:index];

    switch (index) {
        case 0:
                {
                    if (!txtFirstName){
                        txtFirstName = cell.textField;
                        [self setupTextFieldDataWithIndex:index andCell:cell];
                    }
                    else
                        cell.textField.text = txtFirstName.text;
                }
                break;
        case 1:
                {
                    if (!txtLastName){
                        txtLastName = cell.textField;
                        [self setupTextFieldDataWithIndex:index andCell:cell];
                    }
                }
                break;
        case 2:
                {
                    if (!txtStreeetAddress1){
                        txtStreeetAddress1 = cell.textField;
                        [self setupTextFieldDataWithIndex:index andCell:cell];
                    }
                }
                break;
        case 3:
                {
                    if (!txtStreeetAddress2){
                        txtStreeetAddress2 = cell.textField;
                        [self setupTextFieldDataWithIndex:index andCell:cell];
                    }
                }
                break;
        case 4:
                {
                    if (!txtPhoneNo){
                        txtPhoneNo = cell.textField;
                        [self setupTextFieldDataWithIndex:index andCell:cell];
                    }
                }
                break;
        case 5:
                {
                    if (!txtHeight){
                        txtHeight = cell.textField;
                        [self setupTextFieldDataWithIndex:index andCell:cell];
                    }
                }
                break;
        case 6:
                {
                    if (!txtWeight){
                        txtWeight = cell.textField;
                        [self setupTextFieldDataWithIndex:index andCell:cell];
                    }
                }
                break;
        case 7:
                {
                    if (!txtAge){
                        txtAge = cell.textField;
                        [self setupTextFieldDataWithIndex:index andCell:cell];
                    }
                }

                break;
        case 8:
                {
                    if (!txtCountry){
                        txtCountry = cell.textField;
                        [self setupTextFieldDataWithIndex:index andCell:cell];
                    }
                }
                break;
        case 9:
                {
                    if (!txtState){
                        txtState = cell.textField;
                        [self setupTextFieldDataWithIndex:index andCell:cell];
                    }
                }
                break;
        case 10:
                txtCity = cell.textField;
                break;
        case 11:
                {
                    if (!txtAboutMe){
                        txtAboutMe = cell.textField;
                        [self setupTextFieldDataWithIndex:index andCell:cell];
                    }
                }
                break;
        default:
            break;
    }
}

-(void)setupTextFieldDataWithIndex:(NSInteger )Index andCell:(userEditProfileCell *)cell
{
    switch (Index) {
        case 0:
        {
            if (txtFirstName.text.length <= 0) {
                if (_user.FirstName && txtFirstName)
                {
                    txtFirstName.text = _user.FirstName;
                }
                else
                {
                    txtFirstName.text = @"";
                }
            }
            
            
            break;
        }
        case 1:
        {
            if (_user.LastName && txtLastName)
            {
                txtLastName.text = _user.LastName;
            }
            else
            {
                txtLastName.text = @"";
            }

            break;
        }
        case 2:
        {
            if (_user.StreetAddress1 && txtStreeetAddress1)
            {
                txtStreeetAddress1.text = _user.StreetAddress1;
            }
            else
            {
                txtStreeetAddress1.text = @"";
            }

            break;
        }
        case 3:
        {
            if (_user.StreetAddress2 && txtStreeetAddress2)
            {
                txtStreeetAddress2.text = _user.StreetAddress2;
            }
            else
            {
                txtStreeetAddress2.text = @"";
            }

            break;
        }
            
        case 4:
        {
            if (_user.Phone && txtPhoneNo)
            {
                txtPhoneNo.text = _user.Phone;
            }
            else
            {
                txtPhoneNo.text = @"";
            }

            break;
        }
            
        case 5:
        {
            if (_user.Height && txtHeight)
            {
                NSString *height = [NSString stringWithFormat:@"%d", [_user.Height intValue]];
                txtHeight.text = height;
            }
            else
            {
                txtHeight.text = @"";
            }

            break;
        }
            
        case 6:
        {
            if (_user.Weight && txtWeight)
            {
                NSString *weight = [NSString stringWithFormat:@"%d", [_user.Weight intValue]];
                txtWeight.text = weight;
            }
            else
            {
                txtWeight.text = @"";
            }

            break;
            
        }
        case 7:
        {
            if (_user.Age && txtAge)
            {
                NSString *age = [NSString stringWithFormat:@"%d", [_user.Age intValue]];
                txtAge.text = age;
            }
            else
            {
                txtAge.text = @"";
            }

            break;
        }
        case 8:
        {
            if (_user.Country && txtCountry)
            {
                txtCountry.text = _user.Country;
            }
            else
            {
                txtCountry.text = @"";
            }

            break;
        }
        case 9:
        {
            if (_user.State && txtState)
            {
                txtState.text = _user.State;
            }
            else
            {
                txtState.text = @"";
            }

            break;
            
        }
        case 10:
        {
            if (_user.City && txtCity)
            {
                txtCity.text = _user.City;
            }
            else
            {
                txtCity.text = @"";
            }
            break;
        }
            
        case 11:
        {
            if (_user.AboutMe && txtAboutMe)
            {
                txtAboutMe.text = _user.AboutMe;
            }
            else
            {
                txtAboutMe.text = @"";
            }

            break;
        }
        default:
            break;
    }
}
*/

@end
