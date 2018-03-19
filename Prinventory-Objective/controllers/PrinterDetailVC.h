
#import <UIKit/UIKit.h>

#import "Printer.h"

@interface PrinterDetailVC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *nIconImage;
@property (weak, nonatomic) IBOutlet UIImageView *mStatusImage;
@property (weak, nonatomic) IBOutlet UIImageView *mColorImage;

@property (weak, nonatomic) IBOutlet UILabel *mMakeModelLabel;
@property (weak, nonatomic) IBOutlet UILabel *mTModelLabel;
@property (weak, nonatomic) IBOutlet UILabel *mSerialLabel;
@property (weak, nonatomic) IBOutlet UILabel *mStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *mColorLabel;
@property (weak, nonatomic) IBOutlet UILabel *mOwnerLabel;
@property (weak, nonatomic) IBOutlet UILabel *mDeptLabel;
@property (weak, nonatomic) IBOutlet UILabel *mLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *mFloorLabel;
@property (weak, nonatomic) IBOutlet UILabel *mIpLabel;

@property (strong, nonatomic) Printer *mSelectedPrinter;


@end
