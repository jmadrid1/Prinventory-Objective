
#import "VendorTableCell.h"

@implementation VendorTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _mNameLabel.font = [UIFont boldSystemFontOfSize: 14];
    _mPhoneLabel.font = [UIFont systemFontOfSize: 14];
    _mEmailLabel.font = [UIFont systemFontOfSize: 14];
    
    _mPhoneLabel.textColor = [UIColor lightGrayColor];
    _mEmailLabel.textColor = [UIColor lightGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
