
#import "PrinterAddVC.h"
#import "Database.h"

@interface PrinterAddVC ()

@end

@implementation PrinterAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mDatabase = [[Database alloc]init];
    
    _mIconImage.image = [UIImage imageNamed: @"ic_printer.png"];
    
    _mMakeLabel.text = @"Make:";
    _mTModelLabel.text = @"TModel:";
    _mSerialLabel.text = @"Serial:";
    _mStatusLabel.text = @"Status:";
    _mColorLabel.text = @"Color:";
    _mOwnerLabel.text = @"Owner:";
    _mDeptLabel.text = @"Department:";
    _mLocationLabel.text = @"Location:";
    _mFloorLabel.text = @"Floor:";
    _mIpLabel.text = @"IP:";
    
    _mMakeLabel.font = [UIFont systemFontOfSize:14];
    _mTModelLabel.font = [UIFont systemFontOfSize: 14];
    _mSerialLabel.font = [UIFont systemFontOfSize: 14];
    _mStatusLabel.font = [UIFont systemFontOfSize: 14];
    _mColorLabel.font = [UIFont systemFontOfSize: 14];
    _mOwnerLabel.font = [UIFont systemFontOfSize: 14];
    _mDeptLabel.font = [UIFont systemFontOfSize: 14];
    _mLocationLabel.font = [UIFont systemFontOfSize: 14];
    _mFloorLabel.font = [UIFont systemFontOfSize: 14];
    _mIpLabel.font = [UIFont systemFontOfSize: 14];
    
    _mMakeTextField.tag = 0;
    _mModelTextField.tag = 1;
    _mTModelTextField.tag = 2;
    _mSerialTextField.tag = 3;
    _mOwnerTextField.tag = 4;
    _mDeptTextField.tag = 5;
    _mLocationTextField.tag = 6;
    _mFloorTextField.tag = 7;
    _mIpTextField.tag = 8;
    
    _mMakeTextField.placeholder = @"Enter Make";
    _mModelTextField.placeholder = @"Enter Model";
    _mTModelTextField.placeholder = @"Enter Toner Model";
    _mSerialTextField.placeholder = @"Enter Serial";
    _mOwnerTextField.placeholder = @"Enter Owner";
    _mDeptTextField.placeholder = @"Enter Department";
    _mLocationTextField.placeholder = @"Enter Location";
    _mFloorTextField.placeholder = @"Enter Floor";
    _mIpTextField.placeholder = @"Enter IP";
    
    _mMakeTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mModelTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mTModelTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    _mSerialTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    _mOwnerTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mDeptTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mLocationTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mFloorTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;

    _mMakeTextField.returnKeyType = UIReturnKeyDone;
    _mModelTextField.returnKeyType = UIReturnKeyDone;
    _mTModelTextField.returnKeyType = UIReturnKeyDone;
    _mSerialTextField.returnKeyType = UIReturnKeyDone;
    _mOwnerTextField.returnKeyType = UIReturnKeyDone;
    _mDeptTextField.returnKeyType = UIReturnKeyDone;
    _mLocationTextField.returnKeyType = UIReturnKeyDone;
    _mFloorTextField.returnKeyType = UIReturnKeyDone;
    _mIpTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [self addDoneButton];
    
    _mStatusPickerOptions = [[NSArray alloc]initWithObjects: @"Inactive", @"Active", nil];
    _mColorPickerOptions = [[NSArray alloc]initWithObjects: @"BW", @"Color", nil];
    
    [_mSaveButton setTitle: @"Save" forState: normal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
   
    switch (pickerView.tag) {
        case 0:
            return _mStatusPickerOptions.count;
            
        case 1:
            return _mColorPickerOptions.count;
            
        default:
            return 2;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    switch (pickerView.tag) {
        case 0:
            _mStatus = _mStatusPickerOptions[row];
            
        case 1:
            _mColor = _mColorPickerOptions[row];
            
        default:
            return;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    switch (pickerView.tag) {
            
        case 0:
            return [_mStatusPickerOptions objectAtIndex:row];
        case 1:
            return [_mColorPickerOptions objectAtIndex:row];
        default:
            return @"";
    }
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
            return newLength <= 20;
            
        case 1:
            return newLength <= 20;
            
        case 2:
            return newLength <= 10;
            
        case 3:
            return newLength <= 20;
            
        case 4:
            return newLength <= 20;
            
        case 5:
            return newLength <= 15;
            
        case 6:
            return newLength <= 20;
            
        case 7:
            return newLength <= 10;
            
        case 8:
            return newLength <= 3 && isStringValid;
            
        default:
            return newLength <= 15;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    switch (textField.tag) {
            
        case 0:
            [_mMakeTextField resignFirstResponder];
            return TRUE;
            
        case 1:
            [_mModelTextField resignFirstResponder];
            return TRUE;
            
        case 2:
            [_mTModelTextField resignFirstResponder];
            return TRUE;
            
        case 3:
            [_mSerialTextField resignFirstResponder];
            return TRUE;
            
        case 4:
            [_mOwnerTextField resignFirstResponder];
            return TRUE;
            
        case 5:
            [_mDeptTextField resignFirstResponder];
            return TRUE;
            
        case 6:
            [_mLocationTextField resignFirstResponder];
            return TRUE;
            
        case 7:
            [_mFloorTextField resignFirstResponder];
            return TRUE;
        case 8:
            [_mIpTextField resignFirstResponder];
            return TRUE;
            
        default:
            return true;
    }
}

- (void)addDoneButton {
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self.view action:@selector(endEditing:)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    _mIpTextField.inputAccessoryView = keyboardToolbar;
}

- (IBAction) addPrinter {
    
    NSString *make = _mMakeTextField.text;
    NSString *model = _mModelTextField.text;
    NSString *tmodel = _mTModelTextField.text;
    NSString *serial = _mSerialTextField.text;
    NSString *status = _mStatus;
    NSString *color = _mColor;
    NSString *owner = _mOwnerTextField.text;
    NSString *dept = _mDeptTextField.text;
    NSString *location = _mLocationTextField.text;
    NSString *floor = _mFloorTextField.text;
    NSString *ip = _mIpTextField.text;

    [_mDatabase addPrinter:make model:model tmodel:tmodel serial:serial status:status color:color owner:owner dept:dept location:location floor:floor ip:ip];
    [[self navigationController] popViewControllerAnimated: YES];
}

@end
