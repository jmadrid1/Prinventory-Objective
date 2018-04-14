
#import <UIKit/UIKit.h>
#import "Database.h"

@interface VendorVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *mEmptyView;
@property (weak, nonatomic) IBOutlet UIImageView *mEmptyListImage;
@property (weak, nonatomic) IBOutlet UILabel *mEmptyListLabel;

@property (weak, nonatomic) IBOutlet UITableView *mVendorTable;

@property (nonatomic) NSMutableArray *mVendorList;

@property (nonatomic) Database *mDatabase;

@end
