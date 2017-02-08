

#import "LDBaseTableViewController.h"
#import "WHAddressBookModel.h"
typedef void(^AddressBookBlock)(WHAddressBookModel * addBook);
@interface HDAddressBookController : LDBaseTableViewController

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) AddressBookBlock addressBook;

@end
