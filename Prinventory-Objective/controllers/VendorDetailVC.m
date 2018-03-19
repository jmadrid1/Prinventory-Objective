
#import "VendorDetailVC.h"
#import "VendorUpdateVC.h"

@interface VendorDetailVC ()

@end

@implementation VendorDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _mNameLabel.text = _mSelectedVendor.name;
    _mPhoneLabel.text = [NSString stringWithFormat: @"Phone: %@" , _mSelectedVendor.phone];
    _mEmailLabel.text = [NSString stringWithFormat: @"Email: %@" , _mSelectedVendor.email];
    _mStreetLabel.text = [NSString stringWithFormat: @"Street: %@", _mSelectedVendor.street];
    _mCityLabel.text = [NSString stringWithFormat: @"City: %@" , _mSelectedVendor.city];
    _mStateLabel.text = [NSString stringWithFormat: @"State: %@" , _mSelectedVendor.state];
    _mZipcodeLabel.text = [NSString stringWithFormat: @"Zipcode: %@" , _mSelectedVendor.zipcode];
    
    [_mNameLabel setFont: [UIFont boldSystemFontOfSize: _mNameLabel.font.pointSize]];
    
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
