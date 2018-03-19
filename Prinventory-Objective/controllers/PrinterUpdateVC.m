
#import "PrinterUpdateVC.h"
#import "Printer.h"
#import "Database.h"

@interface PrinterUpdateVC ()

@end

@implementation PrinterUpdateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mDatabase = [[Database alloc]init];
    
    _mStatusPickerOptions = [[NSArray alloc]initWithObjects: @"Inactive", @"Active", nil];
    _mColorPickerOptions = [[NSArray alloc]initWithObjects: @"BW", @"Color", nil];
    
    NSString *currentStatus = _mSelectedPrinter.status;
    _mStatusIndex = [_mStatusPickerOptions indexOfObject: currentStatus];
    
    NSString *currentColor = _mSelectedPrinter.color;
    _mColorIndex = [_mColorPickerOptions indexOfObject: currentColor];
    
    _mMakeTextField.text = _mSelectedPrinter.make;
    _mModelTextField.text = _mSelectedPrinter.model;
    _mTModelTextField.text = _mSelectedPrinter.tmodel;
    _mSerialTextField.text = _mSelectedPrinter.serial;
    [_mStatusPicker selectRow: _mStatusIndex inComponent: 0 animated: true];
    [_mColorPicker selectRow: _mColorIndex inComponent: 0 animated: true];
    _mOwnerTextField.text = _mSelectedPrinter.owner;
    _mDeptTextField.text = _mSelectedPrinter.dept;
    _mLocationTextField.text = _mSelectedPrinter.location;
    _mFloorTextField.text = _mSelectedPrinter.floor;
    _mIpTextField.text = _mSelectedPrinter.ip;
    
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

-(IBAction) updatePrinter{
    
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
    
    [_mDatabase updatePrinter: _mSelectedPrinter.id make:make model:model tmodel:tmodel serial:serial status:status color:color owner:owner dept:dept location:location floor:floor ip:ip];
    
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

@end
