
#import "TonerTableCell.h"

@implementation TonerTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _mMakeModelLabel.font = [UIFont boldSystemFontOfSize: 14];
    _mTModelLabel.font = [UIFont systemFontOfSize: 14];
   
    _mMakeModelLabel.textColor = [UIColor lightGrayColor];
    _mTModelLabel.textColor = [UIColor lightGrayColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
