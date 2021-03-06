
#import "VendorVC.h"
#import "VendorTableCell.h"
#import "VendorDetailVC.h"
#import "Database.h"

@interface VendorVC ()

@end

@implementation VendorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mDatabase = [[Database alloc]init];
    
    _mEmptyListImage.image = [UIImage imageNamed:@"ic_list_empty.png"];
    _mEmptyListLabel.text = @"There are currently no vendors available to show";
    [_mEmptyListLabel sizeToFit];

    _mVendorList = [NSMutableArray array];
    
    [_mVendorTable setRowHeight: 50];
    [_mVendorTable reloadData];
    
    [self hideTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self getVendors];
}

- (void)getVendors{
    [_mVendorList removeAllObjects];
    
    _mVendorList = [_mDatabase getVendors];
    [_mVendorTable reloadData];
    
    [self hideTable];
}

/**
 Hides TableView if list does not contain any vendors and shows "Empty List" comment
 */
-(void)hideTable{
    if(_mVendorList.count == 0){
        _mEmptyView.hidden = NO;
        _mVendorTable.hidden = YES;
    }else{
        _mEmptyView.hidden = YES;
        _mVendorTable.hidden = NO;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier: @"vendorDetailSegue" sender: _mVendorList[indexPath.row]];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    VendorTableCell *cell = (VendorTableCell *)[tableView dequeueReusableCellWithIdentifier:@"vendorCell"];
    
    Vendor *vendor = _mVendorList[indexPath.row];
    
    cell.mIconImage.image = [UIImage imageNamed:@"ic_vendor.png"];

    cell.mNameLabel.text = vendor.name;
    cell.mPhoneLabel.text = [NSString stringWithFormat: @"Phone: %@", vendor.phone];
    cell.mEmailLabel.text = [NSString stringWithFormat: @"Email: %@", vendor.email];
    
    [cell.mNameLabel sizeToFit];
    [cell.mPhoneLabel sizeToFit];
    [cell.mEmailLabel sizeToFit];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _mVendorList.count;
}

-(void)setEditing:(BOOL)editing{
    [super setEditing:editing];
    
    [_mVendorTable setEditing:editing];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        [tableView setEditing: YES animated:YES];
        
        Vendor *toBeDeleted = _mVendorList[indexPath.row];
        
        [_mDatabase deleteVendor:toBeDeleted.id];
        
        [_mVendorList removeObjectAtIndex: indexPath.row];
        [tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject:indexPath] withRowAnimation: YES];
        
        [_mVendorTable reloadData];
    }
    [self hideTable];
}

/**
 Passes the selected vendor object from TableView row to the PrinterDetailVC
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"vendorDetailSegue"]){
        VendorDetailVC *vc = segue.destinationViewController;
        vc.mSelectedVendor = (Vendor *) sender;
    }
}

@end
