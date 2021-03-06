
#import <UIKit/UIKit.h>
#import "Database.h"

@interface TonerAddVC : UIViewController<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *mIconImage;

@property (weak, nonatomic) IBOutlet UILabel *mMakeLabel;
@property (weak, nonatomic) IBOutlet UILabel *mModelLabel;
@property (weak, nonatomic) IBOutlet UILabel *mTModelLabel;

@property (weak, nonatomic) IBOutlet UITextField *mMakeTextField;
@property (weak, nonatomic) IBOutlet UITextField *mModelTextField;
@property (weak, nonatomic) IBOutlet UITextField *mTModelTextField;

@property (weak, nonatomic) IBOutlet UIPickerView *mColorPicker;

@property (weak, nonatomic) IBOutlet UILabel *mBlackQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *mCyanQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *mYellowQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *mMagentaQuantityLabel;

@property (weak, nonatomic) IBOutlet UIStepper *mBlackStepper;
@property (weak, nonatomic) IBOutlet UIStepper *mCyanStepper;
@property (weak, nonatomic) IBOutlet UIStepper *mYellowStepper;
@property (weak, nonatomic) IBOutlet UIStepper *mMagentaStepper;

@property (weak, nonatomic) IBOutlet UIButton *mSaveButton;

@property (nonatomic) NSArray *mColorPickerOptions;

@property (nonatomic) NSString *mColorSelected;

@property(nonatomic) Database *mDatabase;


@end
