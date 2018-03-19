
#import "Database.h"
#import <sqlite3.h>
#import "Printer.h"
#import "Toner.h"
#import "Vendor.h"

static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation Database

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self wasTableCreated];
    }
    return self;
}

-(BOOL) wasTableCreated {
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    _databasePath = [[NSString alloc] initWithString:
                     [docsDir stringByAppendingPathComponent: @"prinventory.db"]];
    
    BOOL isSuccess = YES;
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO) {
        
        const char *dbpath = [_databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            
            char *errMsg;
            const char *sql_stmt =
            "create table if not exists printers (id integer primary key autoincrement, make text, model text, tmodel text, serial text, status text, color text, owner text, dept text, location, floor text, ip text)";
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                isSuccess = NO;
                NSLog(@"Failed to create Printer table");
            }
            
            sql_stmt =
            "create table if not exists toners (id integer primary key autoincrement, make text, model text, tmodel text, color text, black text, cyan text, yellow text, magenta text)";
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                isSuccess = NO;
                NSLog(@"Failed to create Toner table");
            }
            
            sql_stmt =
            "create table if not exists vendors (id integer primary key autoincrement, name text, phone text, email text, street text, city text, state text, zipcode text)";
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                isSuccess = NO;
                NSLog(@"Failed to create Vendor table");
            }
            
            sqlite3_close(database);
            
            return  isSuccess;
        } else {
            isSuccess = NO;
            NSLog(@"Failed to create databases");
        }
    }
    return isSuccess;
}

-(NSMutableArray *) getPrinters{
    
    NSMutableArray *printers = [[NSMutableArray alloc] init];
    
    int rc=0;
    rc = sqlite3_open_v2([_databasePath UTF8String], &database, SQLITE_OPEN_READONLY , NULL);
    
    if (SQLITE_OK != rc){
        sqlite3_close(database);
        NSLog(@"Failed to establish database connection");
    }else{
        NSString  * query = @"select * from printers";
        
        rc =sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL);
        if(rc == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW){
                
                NSInteger *id = sqlite3_column_int(statement, 0);
                NSString *make = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *model = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *tmodel = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                NSString *serial = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                NSString *status = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                NSString *color = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                NSString *owner = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                NSString *dept = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 8)];
                NSString *location = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 9)];
                NSString *floor = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 10)];
                NSString *ip = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 11)];
                
                
                Printer *printer = [[Printer alloc]init];
                printer.id = id;
                printer.make = make;
                printer.model = model;
                printer.tmodel = tmodel;
                printer.serial = serial;
                printer.status = status;
                printer.color = color;
                printer.owner = owner;
                printer.dept = dept;
                printer.location = location;
                printer.floor = floor;
                printer.ip = ip;
                
                [printers addObject: printer];
            }
            sqlite3_finalize(statement);
        }else{
            NSLog(@"Failed to prepare statement with rc:%d",rc);
        }
        sqlite3_close(database);
    }
    return printers;
}

- (BOOL)addPrinter:(NSString*)make model:(NSString*)model tmodel:(NSString*)tmodel serial:(NSString*)serial status:(NSString*)status color:(NSString*)color owner:(NSString*)owner dept:(NSString*)dept location:(NSString*)location floor:(NSString*)floor ip:(NSString*)ip; {
    
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, & database) == SQLITE_OK) {
        
        NSString *insertSQL = [NSString stringWithFormat: @"insert into printers (make, model, tmodel, serial, status, color, owner, dept, location, floor, ip) values (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", make, model, tmodel, serial, status, color, owner, dept, location, floor, ip];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"Printer was successfully added!");
            return YES;
        } else {
            NSLog(@"Printer was not added!");
            return NO;
        }
    }
    return NO;
}

- (int) updatePrinter:(NSInteger*) id make:(NSString*)make model:(NSString*)model tmodel:(NSString*)tmodel serial:(NSString*)serial status:(NSString*)status color:(NSString*)color owner:(NSString*)owner dept:(NSString*)dept location:(NSString*)location floor:(NSString*)floor ip:(NSString*)ip {
    
    int rc=0;
    rc = sqlite3_open_v2([_databasePath cStringUsingEncoding:NSUTF8StringEncoding], &database, SQLITE_OPEN_READWRITE , NULL);
    
    if (SQLITE_OK != rc){
        sqlite3_close(database);
        NSLog(@"Failed to establish database connection");
    }else{
        NSString * query  = [NSString
                             stringWithFormat:@"update printers set make='%@', model='%@', tmodel='%@', serial='%@', status='%@', color='%@', owner='%@', dept='%@', location='%@', floor='%@', ip='%@' where id=\"%d\"", make, model, tmodel, serial, status, color, owner, dept, location, floor, ip, id];
        char * errMsg;
        rc = sqlite3_exec(database, [query UTF8String] ,NULL,NULL,&errMsg);
        if(SQLITE_OK != rc){
            NSLog(@"Failed to update Printer  rc:%d, msg=%s",rc,errMsg);
        }
        sqlite3_close(database);
    }
    return  rc;
}

- (int) deletePrinter:(NSInteger*) id {
    
    int rc=0;
    rc = sqlite3_open_v2([_databasePath cStringUsingEncoding:NSUTF8StringEncoding], &database, SQLITE_OPEN_READWRITE , NULL);
    
    if (SQLITE_OK != rc){
        sqlite3_close(database);
        NSLog(@"Failed to establish database connection");
    }else{
        NSString * query  = [NSString
                             stringWithFormat:@"DELETE FROM printers where id=%d", id];
        char * errMsg;
        rc = sqlite3_exec(database, [query UTF8String] ,NULL,NULL,&errMsg);
        if(SQLITE_OK != rc){
            NSLog(@"Failed to delete record  rc:%d, msg=%s",rc,errMsg);
        }
        NSLog(@"Printer has been deleted from database.");
        sqlite3_close(database);
    }
    return  rc;
}

-(NSMutableArray *) getToners{
    
    NSMutableArray *toners = [[NSMutableArray alloc] init];
    
    int rc=0;
    rc = sqlite3_open_v2([_databasePath UTF8String], &database, SQLITE_OPEN_READONLY , NULL);
    
    if (SQLITE_OK != rc){
        sqlite3_close(database);
         NSLog(@"Failed to establish database connection");
    }else{
        NSString  * query = @"select * from toners";
        
        rc =sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL);
        if(rc == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW){

                NSInteger *id = sqlite3_column_int(statement, 0);
                NSString *make = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *model = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *tmodel = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                NSString *color = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                NSString *black = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                NSString *cyan = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                NSString *yellow = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                NSString *magenta = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 8)];

                Toner *toner = [[Toner alloc]init];
                toner.id = id;
                toner.make = make;
                toner.model = model;
                toner.tmodel = tmodel;
                toner.color = color;
                toner.black = [black doubleValue];
                toner.cyan = [cyan doubleValue];
                toner.yellow = [yellow doubleValue];
                toner.magenta = [magenta doubleValue];


                [toners addObject: toner];
            }
            sqlite3_finalize(statement);
        }else{
            NSLog(@"Failed to prepare statement with rc:%d",rc);
        }
        sqlite3_close(database);
    }
    return toners;
}

- (BOOL)addToner:(NSString*)make model:(NSString*)model tmodel:(NSString*)tmodel color:(NSString*)color black:(double)black cyan:(double)cyan yellow:(double)yellow magenta:(double)magenta {
    
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, & database) == SQLITE_OK) {
        
        NSString *insertSQL = [NSString stringWithFormat: @"insert into toners (make, model, tmodel, color, black, cyan, yellow, magenta) values (\"%@\", \"%@\", \"%@\", \"%@\", \"%.f\", \"%.f\", \"%.f\", \"%.f\")", make, model, tmodel, color, black, cyan, yellow, magenta];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            return YES;
        } else {
            NSLog(@"Toner was not added!");
            return NO;
        }
    }
    return NO;
}

- (int) updateToner:(NSInteger*)id make:(NSString*)make model:(NSString*)model tmodel:(NSString*)tmodel color:(NSString*)color black:(double)black cyan:(double)cyan yellow:(double)yellow magenta:(double)magenta {
    
    int rc=0;
    rc = sqlite3_open_v2([_databasePath cStringUsingEncoding:NSUTF8StringEncoding], &database, SQLITE_OPEN_READWRITE , NULL);
    
    if (SQLITE_OK != rc){
        sqlite3_close(database);
        NSLog(@"Failed to establish database connection");
    }else{
        NSString * query  = [NSString
                             stringWithFormat:@"update toners set make='%@', model='%@', tmodel='%@', color='%@', black='%.f', cyan='%.f', yellow='%.f', magenta='%.f' where id=\"%d\"", make, model, tmodel, color, black, cyan, yellow, magenta, id];
        char * errMsg;
        rc = sqlite3_exec(database, [query UTF8String] ,NULL,NULL,&errMsg);
        if(SQLITE_OK != rc){
            NSLog(@"Failed to Update Toner  rc:%d, msg=%s",rc,errMsg);
        }
        sqlite3_close(database);
    }
    return  rc;
}

- (int) deleteToner:(NSInteger*) id {
    
    int rc=0;
    rc = sqlite3_open_v2([_databasePath cStringUsingEncoding:NSUTF8StringEncoding], &database, SQLITE_OPEN_READWRITE , NULL);
    
    if (SQLITE_OK != rc){
        sqlite3_close(database);
        NSLog(@"Failed to establish database connection");
    }else{
        NSString * query  = [NSString
                             stringWithFormat:@"delete from toners where id=%d", id];
        char * errMsg;
        rc = sqlite3_exec(database, [query UTF8String] ,NULL,NULL,&errMsg);
        if(SQLITE_OK != rc){
            NSLog(@"Failed to delete toner  rc:%d, msg=%s",rc,errMsg);
        }
        sqlite3_close(database);
    }
    return  rc;
}

-(NSMutableArray *) getVendors{
    
    NSMutableArray *vendors = [[NSMutableArray alloc] init];
    
    int rc=0;
    rc = sqlite3_open_v2([_databasePath UTF8String], &database, SQLITE_OPEN_READONLY , NULL);
    
    if (SQLITE_OK != rc){
        sqlite3_close(database);
        NSLog(@"Failed to establish database connection");
    }else{
        NSString  *query = @"select * from vendors";
        
        rc =sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL);
        if(rc == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW){
                
                NSInteger *id = sqlite3_column_int(statement, 0);
                NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *phone = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *email = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                NSString *city = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                NSString *street = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                NSString *state = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                NSString *zipcode = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
            
                Vendor *vendor = [[Vendor alloc]init];
                vendor.id = id;
                vendor.name = name;
                vendor.phone = phone;
                vendor.email = email;
                vendor.city = city;
                vendor.street = street;
                vendor.state = state;
                vendor.zipcode = zipcode;
                
                [vendors addObject: vendor];
            }
            sqlite3_finalize(statement);
        }else{
            NSLog(@"Failed to prepare statement with rc:%d",rc);
        }
        sqlite3_close(database);
    }
    return vendors;
}

- (BOOL)addVendor:(NSString*)name phone:(NSString*)phone email:(NSString*)email street:(NSString*)street city:(NSString*)city state:(NSString*)state zipcode:(NSString*)zipcode; {
    
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, & database) == SQLITE_OK) {
        
        NSString *insertSQL = [NSString stringWithFormat: @"insert into vendors (name, phone, email, city, street, state, zipcode) values (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", name, phone, email, street, city, state, zipcode];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"Vendor was successfully added!");
            return YES;
        } else {
            return NO;
        }
    }
    return NO;
}

- (int) updateVendor:(NSInteger*)id name:(NSString*)name phone:(NSString*)phone email:(NSString*)email street:(NSString*)street city:(NSString*)city state:(NSString*)state zipcode:(NSString*)zipcode {
    
    int rc=0;
    rc = sqlite3_open_v2([_databasePath cStringUsingEncoding:NSUTF8StringEncoding], &database, SQLITE_OPEN_READWRITE , NULL);
    
    if (SQLITE_OK != rc){
        sqlite3_close(database);
        NSLog(@"Failed to establish database connection");
    }else{
        NSString * query  = [NSString
                             stringWithFormat:@"update vendors set name='%@', phone='%@', email='%@', street='%@', city='%@', state='%@', zipcode='%@' where id=\"%d\"", name, phone, email, street, city, state, zipcode, id];
        char * errMsg;
        rc = sqlite3_exec(database, [query UTF8String] ,NULL,NULL,&errMsg);
        if(SQLITE_OK != rc){
            NSLog(@"Failed to update vendor  rc:%d, msg=%s",rc,errMsg);
        }
        sqlite3_close(database);
    }
    return  rc;
}

- (int) deleteVendor:(NSInteger*) id {
    
    int rc=0;
    rc = sqlite3_open_v2([_databasePath cStringUsingEncoding:NSUTF8StringEncoding], &database, SQLITE_OPEN_READWRITE , NULL);
    
    if (SQLITE_OK != rc){
        sqlite3_close(database);
        NSLog(@"Failed to establish database connection");
    }else{
        NSString * query  = [NSString
                             stringWithFormat:@"delete from vendors where id=%d", id];
        char * errMsg;
        rc = sqlite3_exec(database, [query UTF8String] ,NULL,NULL,&errMsg);
        if(SQLITE_OK != rc){
            NSLog(@"Failed to delete vendor  rc:%d, msg=%s",rc,errMsg);
        }
        sqlite3_close(database);
    }
    return  rc;
}

@end
