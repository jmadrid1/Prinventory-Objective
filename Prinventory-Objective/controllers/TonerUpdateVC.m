
#import "TonerUpdateVC.h"

@interface TonerUpdateVC ()

@end

@implementation TonerUpdateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mDatabase = [[Database alloc] init];
    
    _mIconImage.image = [UIImage imageNamed: @"ic_toner.png"];
    
    _mMakeLabel.text = @"Make:";
    _mModelLabel.text = @"Model";
    _mTModelLabel.text = @"TModel:";
    
    _mMakeLabel.font = [UIFont systemFontOfSize:14];
    _mModelLabel.font = [UIFont systemFontOfSize:14];
    _mTModelLabel.font = [UIFont systemFontOfSize: 14];
    
    _mMakeTextField.tag = 0;
    _mModelTextField.tag = 1;
    _mTModelTextField.tag = 2;
    
    _mMakeTextField.placeholder = @"Enter Make";
    _mModelTextField.placeholder = @"Enter Model";
    _mTModelTextField.placeholder = @"Enter Toner Model";
    
    _mMakeTextField.text = _mSelectedToner.make;
    _mModelTextField.text = _mSelectedToner.model;
    _mTModelTextField.text = _mSelectedToner.tmodel;
    
    _mMakeTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mModelTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mTModelTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    
    _mMakeTextField.returnKeyType = UIReturnKeyDone;
    _mModelTextField.returnKeyType = UIReturnKeyDone;
    _mTModelTextField.returnKeyType = UIReturnKeyDone;
    
    _mColorPickerOptions = [[NSArray alloc]initWithObjects: @"BW", @"Color", nil];
    
    NSString *currentColor = _mSelectedToner.color;
    _mColorIndex = [_mColorPickerOptions indexOfObject: currentColor];
    
    [_mColorPicker selectRow: _mColorIndex inComponent:0 animated: TRUE];
    
    [_mBlackQuantityLabel setText:[NSString stringWithFormat:@"Black:          %d", (int)_mSelectedToner.black]];
    _mBlackStepper.value = _mSelectedToner.black;
    
    [_mCyanQuantityLabel setText:[NSString stringWithFormat:@"Cyan:          %d", (int)_mSelectedToner.cyan]];
    _mCyanStepper.value = _mSelectedToner.cyan;
    
    [_mYellowQuantityLabel setText:[NSString stringWithFormat:@"Yellow:        %d", (int)_mSelectedToner.yellow]];
    _mYellowStepper.value = _mSelectedToner.yellow;
    
    [_mMagentaQuantityLabel setText:[NSString stringWithFormat:@"Magenta:    %d", (int)_mSelectedToner.magenta]];
    _mMagentaStepper.value = _mSelectedToner.magenta;
    
    [_mBlackQuantityLabel sizeToFit];
    [_mCyanQuantityLabel sizeToFit];
    [_mYellowQuantityLabel sizeToFit];
    [_mMagentaQuantityLabel sizeToFit];
    
    [_mSaveButton setTitle: @"Save Changes" forState: normal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _mColorPickerOptions.count;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    _mColorSelected = _mColorPickerOptions[row];
    
    if(_mColorSelected == _mColorPickerOptions[1]){
        _mCyanQuantityLabel.hidden = NO;
        _mYellowQuantityLabel.hidden = NO;
        _mMagentaQuantityLabel.hidden = NO;
        
        _mCyanStepper.hidden = NO;
        _mYellowStepper.hidden =NO;
        _mMagentaStepper.hidden =NO;
    }else{
        _mCyanQuantityLabel.hidden = YES;
        _mYellowQuantityLabel.hidden = YES;
        _mMagentaQuantityLabel.hidden = YES;
        
        _mCyanStepper.hidden = YES;
        _mYellowStepper.hidden =YES;
        _mMagentaStepper.hidden =YES;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_mColorPickerOptions objectAtIndex:row];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(range.length + range.location > textField.text.length){
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    switch (textField.tag) {
            
        case 0:
            return newLength <= 20;
            
        case 1:
            return newLength <= 15;
            
        case 2:
            return newLength <= 10;
            
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
            
        default:
            return true;
    }
}

- (IBAction)blackSteps:(UIStepper *)sender {
    double steps = [sender value];
    [_mBlackQuantityLabel setText:[NSString stringWithFormat:@"Black:          %d", (int)steps]];
    [_mBlackQuantityLabel sizeToFit];
}

- (IBAction)cyanSteps:(UIStepper *)sender {
    double steps = [sender value];
    [_mCyanQuantityLabel setText:[NSString stringWithFormat:@"Cyan:          %d", (int)steps]];
    [_mCyanQuantityLabel sizeToFit];
}

- (IBAction)yellowSteps:(UIStepper *)sender {
    double steps = [sender value];
    [_mYellowQuantityLabel setText:[NSString stringWithFormat:@"Yellow:        %d", (int)steps]];
    [_mYellowQuantityLabel sizeToFit];
}

- (IBAction)magentaSteps:(UIStepper *)sender {
    double steps = [sender value];
    [_mMagentaQuantityLabel setText:[NSString stringWithFormat:@"Magenta:    %d", (int)steps]];
    [_mMagentaQuantityLabel sizeToFit];
}

/**
 Updates toner information on SQLite Database based off of values from TextFields.
 */
-(IBAction) updateToner{
    
    NSString *make = _mMakeTextField.text;
    NSString *model = _mModelTextField.text;
    NSString *tmodel = _mTModelTextField.text;
    
    if(_mColorSelected == nil){
        _mColorSelected = _mColorPickerOptions[_mColorIndex];
    }
    NSString *color = _mColorSelected;
    
    double black = _mBlackStepper.value;
    double cyan = _mCyanStepper.value;
    double yellow = _mYellowStepper.value;
    double magenta = _mYellowStepper.value;
    
    [_mDatabase updateToner:_mSelectedToner.id make:make model:model tmodel:tmodel color:color black:black cyan:cyan yellow:yellow magenta:magenta];
    
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

@end
