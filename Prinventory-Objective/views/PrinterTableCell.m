
#import "PrinterTableCell.h"

@implementation PrinterTableCell

- (void)awakeFromNib {
    [super awakeFromNib];

    _mMakeModelLabel.font = [UIFont boldSystemFontOfSize: 14];
    _mLocationLabel.font = [UIFont systemFontOfSize: 14];
    _mIpLabel.font = [UIFont systemFontOfSize: 14];
    
    _mMakeModelLabel.textColor = [UIColor lightGrayColor];
    _mLocationLabel.textColor = [UIColor lightGrayColor];
    _mIpLabel.textColor = [UIColor lightGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
