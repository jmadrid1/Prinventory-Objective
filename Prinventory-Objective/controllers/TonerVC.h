
#import <UIKit/UIKit.h>
#import "Database.h"

@interface TonerVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *mEmptyView;
@property (weak, nonatomic) IBOutlet UIImageView *mEmptyListImage;
@property (weak, nonatomic) IBOutlet UILabel *mEmptyListLabel;

@property (weak, nonatomic) IBOutlet UITableView *mTonerTable;

@property(nonatomic) NSMutableArray *mTonerList;

@property(nonatomic) Database *mDatabase;

@end
