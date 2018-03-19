
#import <UIKit/UIKit.h>
#import "Database.h"

@interface VendorAddVC : UIViewController<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *mIconImage;

@property (weak, nonatomic) IBOutlet UITextField *mNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *mEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *mStreetTextField;
@property (weak, nonatomic) IBOutlet UITextField *mCityTextField;
@property (weak, nonatomic) IBOutlet UITextField *mZipcodeTextField;

@property (weak, nonatomic) IBOutlet UIPickerView *mStatePicker;

@property (weak, nonatomic) IBOutlet UIButton *mSaveButton;

@property (nonatomic) NSArray *mStatePickerOptions;
@property (nonatomic) NSString *mState;

@property (nonatomic) Database *mDatabase;

@end
