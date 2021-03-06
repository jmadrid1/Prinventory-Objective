
#import "PrinterVC.h"
#import "Printer.h"
#import "PrinterTableCell.h"
#import "PrinterDetailVC.h"
#import "Database.h"

#import <sqlite3.h>

@interface PrinterVC ()

@end

@implementation PrinterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mDatabase = [[Database alloc]init];
    
    _mEmptyListImage.image = [UIImage imageNamed:@"ic_list_empty.png"];
    _mEmptyListLabel.text = @"There are currently no printers available to show";
    [_mEmptyListLabel sizeToFit];
    
    _mPrinterList = [NSMutableArray array];

    [_mPrinterTable setRowHeight: 50];
    [_mPrinterTable reloadData];
    
    [self hideTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self getPrinters];
}

- (void)getPrinters{
    
    [_mPrinterList removeAllObjects];
    
    _mPrinterList = [_mDatabase getPrinters];
    [_mPrinterTable reloadData];
    
    [self hideTable];
}

/**
 Hides TableView if list does not contain any printers and shows "Empty List" comment
 */
-(void)hideTable{
    if(_mPrinterList.count == 0){
        _mEmptyView.hidden = NO;
        _mPrinterTable.hidden = YES;
    }else{
         _mEmptyView.hidden = YES;
        _mPrinterTable.hidden = NO;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"printerDetailSegue" sender: _mPrinterList[indexPath.row]];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PrinterTableCell *cell = (PrinterTableCell *)[tableView dequeueReusableCellWithIdentifier:@"printerCell"];
    
    Printer *printer = _mPrinterList[indexPath.row];
    
    cell.mIconImage.image = [UIImage imageNamed:@"ic_printer.png"];
    
    cell.mMakeModelLabel.text = [NSString stringWithFormat: @"%@ %@", printer.make, printer.model];
    cell.mLocationLabel.text = [NSString stringWithFormat: @"Location: %@", printer.location];
    cell.mIpLabel.text = [NSString stringWithFormat: @"IP: %@", printer.ip];
    
    [cell.mMakeModelLabel sizeToFit];
    [cell.mLocationLabel sizeToFit];
    [cell.mIpLabel sizeToFit];
    
    if([printer.status isEqual: @"Inactive"]){
        cell.mStatusImage.image = [UIImage imageNamed:@"ic_status_inactive.png"];
    }else{
        cell.mStatusImage.image = [UIImage imageNamed:@"ic_status_active.png"];
    }
    
    if([printer.color isEqual: @"Color"]){
        cell.mColorImage.image = [UIImage imageNamed:@"ic_color.png"];
    }else{
        cell.mColorImage.image = [UIImage imageNamed:@"ic_bw.png"];
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _mPrinterList.count;
}

-(void)setEditing:(BOOL)editing{
    [super setEditing:editing];
    
    [_mPrinterTable setEditing:editing];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        [tableView setEditing: YES animated:YES];
        
        Printer *toBeDeleted = _mPrinterList[indexPath.row];
     
        [_mDatabase deletePrinter:toBeDeleted.id];
        
        [_mPrinterList removeObjectAtIndex: indexPath.row];
        [_mPrinterTable deleteRowsAtIndexPaths: [NSArray arrayWithObject:indexPath] withRowAnimation: YES];
    }
    [self hideTable];
}

/**
 Passes the selected printer object from TableView row to the PrinterDetailVC
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"printerDetailSegue"]){
        PrinterDetailVC *vc = segue.destinationViewController;
        vc.mSelectedPrinter = (Printer *) sender;
    }
}

@end
