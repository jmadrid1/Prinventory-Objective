
#import <UIKit/UIKit.h>
#import "Vendor.h"

@interface VendorDetailVC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *mIconImage;

@property (weak, nonatomic) IBOutlet UILabel *mNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mPhoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *mEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *mStreetLabel;
@property (weak, nonatomic) IBOutlet UILabel *mCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *mStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *mZipcodeLabel;

@property (strong, nonatomic) Vendor *mSelectedVendor;

@end
