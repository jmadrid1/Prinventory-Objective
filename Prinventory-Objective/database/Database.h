
#import <Foundation/Foundation.h>

@interface Database : NSObject

@property (nonatomic) NSString *databasePath;

-(BOOL)wasTableCreated;

-(NSMutableArray*)getPrinters;
-(NSMutableArray*)getToners;
-(NSMutableArray*)getVendors;

- (BOOL)addPrinter:(NSString*)make model:(NSString*)model tmodel:(NSString*)tmodel serial:(NSString*)serial status:(NSString*)status color:(NSString*)color owner:(NSString*)owner dept:(NSString*)dept location:(NSString*)location floor:(NSString*)floor ip:(NSString*)ip;

-(BOOL)addToner:(NSString *)make model:(NSString *)model tmodel:(NSString *)tmodel color:(NSString *)color black:(double)black cyan:(double)cyan yellow:(double)yellow magenta:(double)magenta;

-(BOOL)addVendor:(NSString *)name phone:(NSString *)phone email:(NSString *)email street:(NSString *)street city:(NSString *)city state:(NSString *)state zipcode:(NSString *)zipcode;


- (int) updatePrinter:(NSInteger*) id make:(NSString*)make model:(NSString*)model tmodel:(NSString*)tmodel serial:(NSString*)serial status:(NSString*)status color:(NSString*)color owner:(NSString*)owner dept:(NSString*)dept location:(NSString*)location floor:(NSString*)floor ip:(NSString*)ip;

- (int) updateToner:(NSInteger*)id make:(NSString*)make model:(NSString*)model tmodel:(NSString*)tmodel color:(NSString*)color black:(double)black cyan:(double)cyan yellow:(double)yellow magenta:(double)magenta;

- (int) updateVendor:(NSInteger*)id name:(NSString*)name phone:(NSString*)phone email:(NSString*)email street:(NSString*)street city:(NSString*)city state:(NSString*)state zipcode:(NSString*)zipcode;

- (int) deletePrinter:(NSInteger*) id;
- (int) deleteToner:(NSInteger*) id;
- (int) deleteVendor:(NSInteger*) id;

@end
