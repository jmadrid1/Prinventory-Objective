
#import <UIKit/UIKit.h>

@interface PrinterTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mIconImage;
@property (weak, nonatomic) IBOutlet UILabel *mMakeModelLabel;

@property (weak, nonatomic) IBOutlet UILabel *mLocationLabel;

@property (weak, nonatomic) IBOutlet UILabel *mIpLabel;


@property (weak, nonatomic) IBOutlet UIImageView *mStatusImage;
@property (weak, nonatomic) IBOutlet UIImageView *mColorImage;

@end
