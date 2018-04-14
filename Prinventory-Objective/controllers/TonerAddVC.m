
#import "TonerAddVC.h"
#import "Database.h"

@interface TonerAddVC ()

@end

@implementation TonerAddVC

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
    
    _mMakeTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mModelTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mTModelTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    
    _mMakeTextField.returnKeyType = UIReturnKeyDone;
    _mModelTextField.returnKeyType = UIReturnKeyDone;
    _mTModelTextField.returnKeyType = UIReturnKeyDone;
    
    _mColorPickerOptions = [[NSArray alloc]initWithObjects: @"BW", @"Color", nil];
    
    _mBlackQuantityLabel.text = @"Black:          0";
    _mCyanQuantityLabel.text = @"Cyan:          0";
    _mYellowQuantityLabel.text = @"Yellow:        0";
    _mMagentaQuantityLabel.text = @"Magenta:    0";
    
    _mYellowQuantityLabel.hidden = YES;
    _mCyanQuantityLabel.hidden = YES;
    _mMagentaQuantityLabel.hidden = YES;
    
    _mCyanStepper.hidden = YES;
    _mYellowStepper.hidden =YES;
    _mMagentaStepper.hidden =YES;
    
    [_mSaveButton setTitle: @"Save" forState: normal];
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
}

- (IBAction)cyanSteps:(UIStepper *)sender {
    double steps = [sender value];
    [_mCyanQuantityLabel setText:[NSString stringWithFormat:@"Cyan:          %d", (int)steps]];
}

- (IBAction)yellowSteps:(UIStepper *)sender {
    double steps = [sender value];
    [_mYellowQuantityLabel setText:[NSString stringWithFormat:@"Yellow:        %d", (int)steps]];
}

- (IBAction)magentaSteps:(UIStepper *)sender {
    double steps = [sender value];
    [_mMagentaQuantityLabel setText:[NSString stringWithFormat:@"Magenta:    %d", (int)steps]];
}

/**
 Saves toner to the SQLite Database based off of values from TextFields, UIPickerView & UISteppers.
 */
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
