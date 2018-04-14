
#import "VendorUpdateVC.h"
#import "Database.h"

@interface VendorUpdateVC ()

@end

@implementation VendorUpdateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mDatabase = [[Database alloc] init];
    
    _mIconImage.image = [UIImage imageNamed: @"ic_vendor.png"];

    _mNameLabel.text = @"Name:";
    _mPhoneLabel.text = @"Phone:";
    _mEmailLabel.text = @"Email:";
    _mStreetLabel.text = @"Street:";
    _mCityLabel.text = @"City:";
    _mStateLabel.text = @"State";
    _mZipcodeLabel.text = @"Zipcode";
    
    _mNameLabel.font = [UIFont systemFontOfSize:14];
    _mPhoneLabel.font = [UIFont systemFontOfSize:14];
    _mEmailLabel.font = [UIFont systemFontOfSize: 14];
    _mStreetLabel.font = [UIFont systemFontOfSize:14];
    _mCityLabel.font = [UIFont systemFontOfSize:14];
    _mStateLabel.font = [UIFont systemFontOfSize: 14];
    _mZipcodeLabel.font = [UIFont systemFontOfSize:14];
    
    _mNameTextField.tag = 0;
    _mPhoneTextField.tag = 1;
    _mEmailTextField.tag = 2;
    _mStreetTextField.tag = 3;
    _mCityTextField.tag = 4;
    _mZipcodeTextField.tag = 5;
    
    _mNameTextField.placeholder = @"Enter Name";
    _mPhoneTextField.placeholder = @"XXX-XXX-XXXX";
    _mEmailTextField.placeholder = @"Enter Email";
    _mStreetTextField.placeholder = @"Enter Street";
    _mCityTextField.placeholder = @"Enter City";
    _mZipcodeTextField.placeholder = @"Enter Zipcode";
    
    _mNameTextField.text = _mSelectedVendor.name;
    _mPhoneTextField.text = _mSelectedVendor.phone;
    _mEmailTextField.text = _mSelectedVendor.email;
    _mCityTextField.text = _mSelectedVendor.city;
    _mStreetTextField.text = _mSelectedVendor.street;
    _mZipcodeTextField.text = _mSelectedVendor.zipcode;
    
    _mNameTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mEmailTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mCityTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mStreetTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    _mNameTextField.returnKeyType = UIReturnKeyDone;
    _mEmailTextField.returnKeyType = UIReturnKeyDone;
    _mCityTextField.returnKeyType = UIReturnKeyDone;
    _mStreetTextField.returnKeyType = UIReturnKeyDone;
    _mPhoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    _mZipcodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [self addDoneButtonsToFields];
    
    [_mStatePicker selectRow: _mStateIndex inComponent: 0 animated: TRUE];
    
    _mStatePickerOptions = [[NSArray alloc]initWithObjects: @"AK", @"AL", @"AR", @"AS", @"AZ",@"CA", @"CO", @"CT", @"DC", @"DE", @"FL",
                            @"GA", @"GU", @"HI", @"IA", @"ID", @"IL", @"IN", @"KS", @"KY", @"LA", @"MA",
                            @"MD", @"ME", @"MI", @"MN", @"MO", @"MS", @"MT", @"NC", @"ND", @"NE", @"NH",
                            @"NJ", @"NM", @"NV", @"NY", @"OH", @"OK", @"OR", @"PA", @"PR", @"RI", @"SC",
                            @"SD", @"TN", @"TX", @"UT", @"VA", @"VI", @"VT", @"WA", @"WI", @"WV", @"WY", nil];
    
    NSString *currentState = _mSelectedVendor.state;
    _mStateIndex = [_mStatePickerOptions indexOfObject: currentState];
    
    [_mSaveButton setTitle: @"Save Changes" forState: normal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _mStatePickerOptions.count;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _mState = _mStatePickerOptions[row];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_mStatePickerOptions objectAtIndex:row];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(range.length + range.location > textField.text.length){
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSCharacterSet *charactersFromTextField = [NSCharacterSet characterSetWithCharactersInString: string];
    
    BOOL isStringValid = [numbers isSupersetOfSet:charactersFromTextField];
    
    switch (textField.tag) {
            
        case 0:
            return newLength <= 30;
            
        case 1:
            return newLength <= 10 && isStringValid;
            
        case 2:
            return newLength <= 35;
            
        case 3:
            return newLength <= 30;
            
        case 4:
            return newLength <= 20;
            
        case 5:
            return newLength <= 5 && isStringValid;
            
        default:
            return newLength <= 15;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    switch (textField.tag) {
            
        case 0:
            [_mNameTextField resignFirstResponder];
            return TRUE;
            
        case 1:
            [_mPhoneTextField resignFirstResponder];
            return TRUE;
            
        case 2:
            [_mEmailTextField resignFirstResponder];
            return TRUE;
            
        case 3:
            [_mStreetTextField resignFirstResponder];
            return TRUE;
            
        case 4:
            [_mCityTextField resignFirstResponder];
            return TRUE;
            
        case 5:
            [_mZipcodeTextField resignFirstResponder];
            return TRUE;
            
        default:
            return true;
    }
}

- (void)addDoneButtonsToFields {
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self.view action:@selector(endEditing:)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    _mPhoneTextField.inputAccessoryView = keyboardToolbar;
    _mZipcodeTextField.inputAccessoryView = keyboardToolbar;
}

-(IBAction) updateVendor{
    
    NSString *name = _mNameTextField.text;
    NSString *phone = _mPhoneTextField.text;
    NSString *email = _mEmailTextField.text;
    NSString *street = _mStreetTextField.text;
    NSString *city = _mCityTextField.text;
    NSString *state = _mState;
    NSString *zipcode = _mZipcodeTextField.text;
    
    [_mDatabase updateVendor:_mSelectedVendor.id name:name phone:phone email:email street:street city:city state:state zipcode:zipcode];
    
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

@end
