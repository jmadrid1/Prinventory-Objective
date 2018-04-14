
#import <UIKit/UIKit.h>
#import "Database.h"

@interface PrinterVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *mEmptyView;
@property (weak, nonatomic) IBOutlet UIImageView *mEmptyListImage;
@property (weak, nonatomic) IBOutlet UILabel *mEmptyListLabel;

@property (weak, nonatomic) IBOutlet UITableView *mPrinterTable;

@property (nonatomic) NSMutableArray *mPrinterList;

@property(nonatomic) Database *mDatabase;

@end
