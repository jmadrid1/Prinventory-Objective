
#import "TonerDetailVC.h"
#import "TonerUpdateVC.h"

@interface TonerDetailVC ()

@end

@implementation TonerDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mIconImage.image = [UIImage imageNamed: @"ic_toner.png"];
    
    _mMakeModelLabel.text = [NSString stringWithFormat: @"%@ %@", _mSelectedToner.make, _mSelectedToner.model];
    _mTModelLabel.text = [NSString stringWithFormat: @"Toner Model: %@", _mSelectedToner.tmodel];
    _mColorLabel.text = [NSString stringWithFormat: @"Color: %@", _mSelectedToner.color];
    _mBlackLabel.text = [NSString stringWithFormat: @"Black: %.f", _mSelectedToner.black];
    _mCyanLabel.text = [NSString stringWithFormat: @"Cyan: %.f", _mSelectedToner.cyan];
    _mYellowLabel.text = [NSString stringWithFormat: @"Yellow: %.f", _mSelectedToner.yellow];
    _mMagentaLabel.text = [NSString stringWithFormat: @"Magenta: %.f", _mSelectedToner.black];
    
    _mMakeModelLabel.font = [UIFont boldSystemFontOfSize: 23];
    _mTModelLabel.textColor = UIColor.lightGrayColor;
    _mColorLabel.textColor = UIColor.lightGrayColor;
    _mBlackLabel.textColor = UIColor.lightGrayColor;
    _mCyanLabel.textColor = UIColor.lightGrayColor;
    _mYellowLabel.textColor = UIColor.lightGrayColor;
    _mMagentaLabel.textColor = UIColor.lightGrayColor;
 
    _mMakeModelLabel.font = [UIFont boldSystemFontOfSize:23];
    _mTModelLabel.font = [UIFont systemFontOfSize: 16];
    _mColorLabel.font = [UIFont systemFontOfSize: 16];
    _mBlackLabel.font = [UIFont systemFontOfSize: 16];
    _mCyanLabel.font = [UIFont systemFontOfSize: 16];
    _mYellowLabel.font = [UIFont systemFontOfSize: 16];
    _mMagentaLabel.font = [UIFont systemFontOfSize: 16];
    
    [_mMakeModelLabel sizeToFit];
    [_mTModelLabel sizeToFit];
    [_mColorLabel sizeToFit];
    [_mBlackLabel sizeToFit];
    [_mCyanLabel sizeToFit];
    [_mYellowLabel sizeToFit];
    [_mMagentaLabel sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 Passes Toner object to PrinterUpdateVC
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"tonerUpdateSegue"]){
        TonerUpdateVC *vc = segue.destinationViewController;
        vc.mSelectedToner = _mSelectedToner;
    }
}

@end
