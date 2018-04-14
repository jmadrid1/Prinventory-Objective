
#import "VendorDetailVC.h"
#import "VendorUpdateVC.h"

@interface VendorDetailVC ()

@end

@implementation VendorDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mIconImage.image = [UIImage imageNamed: @"ic_vendor.png"];
   
    _mNameLabel.text = _mSelectedVendor.name;
    _mPhoneLabel.text = [NSString stringWithFormat: @"Phone: %@" , _mSelectedVendor.phone];
    _mEmailLabel.text = [NSString stringWithFormat: @"Email: %@" , _mSelectedVendor.email];
    _mStreetLabel.text = [NSString stringWithFormat: @"Street: %@", _mSelectedVendor.street];
    _mCityLabel.text = [NSString stringWithFormat: @"City: %@" , _mSelectedVendor.city];
    _mStateLabel.text = [NSString stringWithFormat: @"State: %@" , _mSelectedVendor.state];
    _mZipcodeLabel.text = [NSString stringWithFormat: @"Zipcode: %@" , _mSelectedVendor.zipcode];
    
    _mPhoneLabel.textColor = UIColor.lightGrayColor;
    _mEmailLabel.textColor = UIColor.lightGrayColor;
    _mStreetLabel.textColor = UIColor.lightGrayColor;
    _mCityLabel.textColor = UIColor.lightGrayColor;
    _mStateLabel.textColor = UIColor.lightGrayColor;
    _mZipcodeLabel.textColor = UIColor.lightGrayColor;
    
    _mNameLabel.font = [UIFont boldSystemFontOfSize: 23];
    _mPhoneLabel.font = [UIFont systemFontOfSize: 16];
    _mEmailLabel.font = [UIFont systemFontOfSize: 16];
    _mStreetLabel.font = [UIFont systemFontOfSize: 16];
    _mCityLabel.font = [UIFont systemFontOfSize: 16];
    _mStateLabel.font = [UIFont systemFontOfSize: 16];
    _mZipcodeLabel.font = [UIFont systemFontOfSize: 16];
    
    [_mNameLabel sizeToFit];
    [_mPhoneLabel sizeToFit];
    [_mEmailLabel sizeToFit];
    [_mStreetLabel sizeToFit];
    [_mCityLabel sizeToFit];
    [_mStateLabel sizeToFit];
    [_mZipcodeLabel sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"vendorUpdateSegue"]){
        VendorUpdateVC *vc = segue.destinationViewController;
        vc.mSelectedVendor = _mSelectedVendor;
    }
}

@end
