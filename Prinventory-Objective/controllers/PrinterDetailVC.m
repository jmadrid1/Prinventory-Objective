
#import "PrinterDetailVC.h"
#import "PrinterUpdateVC.h"
#import "Printer.h"

@interface PrinterDetailVC ()

@end

@implementation PrinterDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    _mIconImage.image = [UIImage imageNamed: @"ic_printer.png"];
    
    if([_mSelectedPrinter.status isEqual: @"Inactive"]){
        _mStatusImage.image = [UIImage imageNamed:@"ic_status_inactive.png"];
    }else{
        _mStatusImage.image = [UIImage imageNamed:@"ic_status_active.png"];
    }
    
    if([_mSelectedPrinter.color isEqual: @"Color"]){
        _mColorImage.image = [UIImage imageNamed:@"ic_color.png"];
    }else{
        _mColorImage.image = [UIImage imageNamed:@"ic_bw.png"];
    }
    
    _mMakeModelLabel.text = [NSString stringWithFormat: @"%@ %@", _mSelectedPrinter.make, _mSelectedPrinter.model];
    _mTModelLabel.text = [NSString stringWithFormat:@"Toner Model: %@", _mSelectedPrinter.tmodel];
    _mSerialLabel.text = [NSString stringWithFormat:@"Serial: %@", _mSelectedPrinter.serial];
    _mStatusLabel.text = [NSString stringWithFormat: @"Status: %@", _mSelectedPrinter.status];
    _mColorLabel.text = [NSString stringWithFormat: @"Color: %@", _mSelectedPrinter.color];
    _mOwnerLabel.text = [NSString stringWithFormat: @"Owner: %@", _mSelectedPrinter.owner];
    _mDeptLabel.text = [NSString stringWithFormat: @"Department: %@", _mSelectedPrinter.dept];
    _mLocationLabel.text = [NSString stringWithFormat: @"Location: %@", _mSelectedPrinter.location];
    _mFloorLabel.text = [NSString stringWithFormat: @"Floor: %@", _mSelectedPrinter.floor];
    _mIpLabel.text = [NSString stringWithFormat: @"IP: %@", _mSelectedPrinter.ip];
    
    _mTModelLabel.textColor = UIColor.lightGrayColor;
    _mSerialLabel.textColor = UIColor.lightGrayColor;
    _mStatusLabel.textColor = UIColor.lightGrayColor;
    _mColorLabel.textColor = UIColor.lightGrayColor;
    _mOwnerLabel.textColor = UIColor.lightGrayColor;
    _mDeptLabel.textColor = UIColor.lightGrayColor;
    _mLocationLabel.textColor = UIColor.lightGrayColor;
    _mFloorLabel.textColor = UIColor.lightGrayColor;
    _mIpLabel.textColor = UIColor.lightGrayColor;
    
    _mMakeModelLabel.font = [UIFont boldSystemFontOfSize:23];
    _mTModelLabel.font = [UIFont systemFontOfSize: 14];
    _mSerialLabel.font = [UIFont systemFontOfSize: 14];
    _mStatusLabel.font = [UIFont systemFontOfSize: 14];
    _mColorLabel.font = [UIFont systemFontOfSize: 14];
    _mOwnerLabel.font = [UIFont systemFontOfSize: 14];
    _mDeptLabel.font = [UIFont systemFontOfSize: 14];
    _mLocationLabel.font = [UIFont systemFontOfSize: 14];
    _mFloorLabel.font = [UIFont systemFontOfSize: 14];
    _mIpLabel.font = [UIFont systemFontOfSize: 14];
    
    [_mMakeModelLabel sizeToFit];
    [_mTModelLabel sizeToFit];
    [_mSerialLabel sizeToFit];
    [_mStatusLabel sizeToFit];
    [_mColorLabel sizeToFit];
    [_mOwnerLabel sizeToFit];
    [_mDeptLabel sizeToFit];
    [_mLocationLabel sizeToFit];
    [_mFloorLabel sizeToFit];
    [_mIpLabel sizeToFit];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"printerUpdateSegue"]){
        PrinterUpdateVC *vc = segue.destinationViewController;
        vc.mSelectedPrinter = _mSelectedPrinter;
    }
}

@end
