
#import <UIKit/UIKit.h>
#import "Database.h"

@interface VendorVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mVendorTable;
@property (weak, nonatomic) IBOutlet UIImageView *mEmptyListImage;
@property (weak, nonatomic) IBOutlet UILabel *mEmptyListLabel;

@property (nonatomic) NSMutableArray *mVendorList;

@property (nonatomic) Database *mDatabase;

@end
