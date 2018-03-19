
#import <UIKit/UIKit.h>
#import "Database.h"

@interface PrinterVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mPrinterTable;

@property (weak, nonatomic) IBOutlet UIImageView *mEmptyListImage;
@property (weak, nonatomic) IBOutlet UILabel *mEmptyListLabel;

@property (nonatomic) NSMutableArray *mPrinterList;

@property(nonatomic) Database *mDatabase;

@end
