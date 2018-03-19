
#import <UIKit/UIKit.h>
#import "Toner.h"

@interface TonerDetailVC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *mIconImage;
@property (weak, nonatomic) IBOutlet UILabel *mMakeModelLabel;
@property (weak, nonatomic) IBOutlet UILabel *mTModelLabel;
@property (weak, nonatomic) IBOutlet UILabel *mColorLabel;

@property (weak, nonatomic) IBOutlet UILabel *mBlackLabel;
@property (weak, nonatomic) IBOutlet UILabel *mCyanLabel;
@property (weak, nonatomic) IBOutlet UILabel *mYellowLabel;
@property (weak, nonatomic) IBOutlet UILabel *mMagentaLabel;

@property (nonatomic) Toner *mSelectedToner;

@end
