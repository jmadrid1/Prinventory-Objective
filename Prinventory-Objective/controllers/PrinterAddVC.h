
#import <UIKit/UIKit.h>
#import "Database.h"

@interface PrinterAddVC : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *mIconImage;

@property (weak, nonatomic) IBOutlet UILabel *mMakeLabel;
@property (weak, nonatomic) IBOutlet UILabel *mModelLabel;
@property (weak, nonatomic) IBOutlet UILabel *mTModelLabel;
@property (weak, nonatomic) IBOutlet UILabel *mSerialLabel;
@property (weak, nonatomic) IBOutlet UILabel *mStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *mColorLabel;
@property (weak, nonatomic) IBOutlet UILabel *mOwnerLabel;
@property (weak, nonatomic) IBOutlet UILabel *mDeptLabel;
@property (weak, nonatomic) IBOutlet UILabel *mLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *mFloorLabel;
@property (weak, nonatomic) IBOutlet UILabel *mIpLabel;

@property (weak, nonatomic) IBOutlet UITextField *mMakeTextField;
@property (weak, nonatomic) IBOutlet UITextField *mModelTextField;
@property (weak, nonatomic) IBOutlet UITextField *mSerialTextField;
@property (weak, nonatomic) IBOutlet UITextField *mTModelTextField;
@property (weak, nonatomic) IBOutlet UITextField *mOwnerTextField;
@property (weak, nonatomic) IBOutlet UITextField *mDeptTextField;
@property (weak, nonatomic) IBOutlet UITextField *mLocationTextField;
@property (weak, nonatomic) IBOutlet UITextField *mFloorTextField;
@property (weak, nonatomic) IBOutlet UITextField *mIpTextField;

@property (weak, nonatomic) IBOutlet UIButton *mSaveButton;

@property (weak, nonatomic) IBOutlet UIPickerView *_mStatusPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *mColorPicker;


@property (nonatomic) NSArray *mStatusPickerOptions;
@property (nonatomic) NSArray *mColorPickerOptions;

@property (nonatomic) NSString *mStatus;
@property (nonatomic) NSString *mColor;

@property (nonatomic) Database *mDatabase;

@end
