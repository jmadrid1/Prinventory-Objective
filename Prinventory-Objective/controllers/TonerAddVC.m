
#import "TonerAddVC.h"
#import "Database.h"

@interface TonerAddVC ()

@end

@implementation TonerAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mDatabase = [[Database alloc] init];
    
    _mColorPickerOptions = [[NSArray alloc]initWithObjects: @"BW", @"Color", nil];
    
    _mCyanLabel.hidden = YES;
    _mCyanQuantityLabel.hidden = YES;
    _mCyanStepper.hidden = YES;
    
    _mYellowLabel.hidden = YES;
    _mYellowQuantityLabel.hidden = YES;
    _mYellowStepper.hidden =YES;
    
    _mMagentaLabel.hidden = YES;
    _mMagentaQuantityLabel.hidden = YES;
    _mMagentaStepper.hidden =YES;
    
    _mMakeTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mModelTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mTModelTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    
    _mMakeTextField.returnKeyType = UIReturnKeyDone;
    _mModelTextField.returnKeyType = UIReturnKeyDone;
    _mTModelTextField.returnKeyType = UIReturnKeyDone;
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
        _mCyanLabel.hidden = NO;
        _mCyanQuantityLabel.hidden = NO;
        _mCyanStepper.hidden = NO;
        
        _mYellowLabel.hidden = NO;
        _mYellowQuantityLabel.hidden = NO;
        _mYellowStepper.hidden =NO;
        
        _mMagentaLabel.hidden = NO;
        _mMagentaQuantityLabel.hidden = NO;
        _mMagentaStepper.hidden =NO;
    }else{
        _mCyanLabel.hidden = YES;
        _mCyanQuantityLabel.hidden = YES;
        _mCyanStepper.hidden = YES;
        
        _mYellowLabel.hidden = YES;
        _mYellowQuantityLabel.hidden = YES;
        _mYellowStepper.hidden =YES;
        
        _mMagentaLabel.hidden = YES;
        _mMagentaQuantityLabel.hidden = YES;
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
    [_MBlackQuantityLabel setText:[NSString stringWithFormat:@"%d", (int)steps]];
}

- (IBAction)cyanSteps:(UIStepper *)sender {
    double steps = [sender value];
    [_mCyanQuantityLabel setText:[NSString stringWithFormat:@"%d", (int)steps]];
}

- (IBAction)yellowSteps:(UIStepper *)sender {
    double steps = [sender value];
    [_mYellowQuantityLabel setText:[NSString stringWithFormat:@"%d", (int)steps]];
}

- (IBAction)magentaSteps:(UIStepper *)sender {
    double steps = [sender value];
    [_mMagentaQuantityLabel setText:[NSString stringWithFormat:@"%d", (int)steps]];
}

-(IBAction) addToner{
    
    NSString *make = _mMakeTextField.text;
    NSString *model = _mModelTextField.text;
    NSString *tmodel = _mTModelTextField.text;
    NSString *color = _mColorSelected;
    double black = _mBlackStepper.value;
    double cyan = _mCyanStepper.value;
    double yellow = _mYellowStepper.value;
    double magenta = _mYellowStepper.value;

    [_mDatabase addToner:make model:model tmodel:tmodel color:color black:black cyan:cyan yellow:yellow magenta:magenta];
    
    [[self navigationController] popViewControllerAnimated: YES];
}

@end
