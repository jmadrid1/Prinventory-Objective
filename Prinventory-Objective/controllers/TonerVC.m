
#import "TonerVC.h"
#import "TonerDetailVC.h"
#import "TonerTableCell.h"
#import "Database.h"

@interface TonerVC ()

@end

@implementation TonerVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _mDatabase = [[Database alloc]init];
    
    _mEmptyListImage.image = [UIImage imageNamed:@"ic_list_empty.png"];
    _mEmptyListLabel.text = @"There are currently no toners available to show";
    [_mEmptyListLabel sizeToFit];
    
    _mTonerTable.hidden = YES;
    
    _mTonerList = [NSMutableArray array];
    
    [_mTonerTable setRowHeight: 50];
    [_mTonerTable reloadData];
    
    [self hideTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self getToners];
}

- (void)getToners{
    
    [_mTonerList removeAllObjects];
    
    NSLog(@"%@", _mTonerList.count);
    
    _mTonerList = [_mDatabase getToners];
    [_mTonerTable reloadData];
    
    [self hideTable];
}

-(void)hideTable{
    if(_mTonerList.count == 0){
        _mTonerTable.hidden = YES;
        _mEmptyListLabel.hidden = NO;
        _mEmptyListImage.hidden = NO;
    }else{
        _mTonerTable.hidden = NO;
        _mEmptyListLabel.hidden = YES;
        _mEmptyListImage.hidden = YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier: @"tonerDetailSegue" sender: _mTonerList[indexPath.row]];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TonerTableCell *cell = (TonerTableCell *)[tableView dequeueReusableCellWithIdentifier:@"tonerCell"];
    
    Toner *toner = _mTonerList[indexPath.row];
    
    cell.mIconImage.image = [UIImage imageNamed:@"ic_toner.png"];
    
    [cell.mMakeModelLabel setFont: [UIFont boldSystemFontOfSize: cell.mMakeModelLabel.font.pointSize]];
    
    cell.mMakeModelLabel.text = [NSString stringWithFormat:@"%@ %@", toner.make, toner.model];
    cell.mTModelLabel.text = [NSString stringWithFormat: @"Toner Model: %@", toner.tmodel];
    
    [cell.mMakeModelLabel sizeToFit];
    [cell.mTModelLabel sizeToFit];
    
    if([toner.color isEqual: @"Color"]){
        cell.mColorImage.image = [UIImage imageNamed:@"ic_color.png"];
    }else{
        cell.mColorImage.image = [UIImage imageNamed:@"ic_bw.png"];
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _mTonerList.count;
}

-(void)setEditing:(BOOL)editing{
    [super setEditing:editing];
    
    [_mTonerTable setEditing:editing];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        [tableView setEditing: YES animated:YES];
        
        Toner *toBeDeleted = _mTonerList[indexPath.row];
        
        [_mDatabase deleteToner:toBeDeleted.id];
        
        [_mTonerList removeObjectAtIndex: indexPath.row];
        [_mTonerTable deleteRowsAtIndexPaths: [NSArray arrayWithObject:indexPath] withRowAnimation: YES];
    }
    [self hideTable];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"tonerDetailSegue"]){
        TonerDetailVC *vc = segue.destinationViewController;
        vc.mSelectedToner = (Toner *) sender;
    }
}


@end
