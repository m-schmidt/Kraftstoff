// SwitchTableCell.h
//
// Kraftstoff


#import "PageCell.h"
#import "EditablePageCell.h"



@interface SwitchTableCell : PageCell {}

@property (nonatomic, strong) UISwitch *valueSwitch;
@property (nonatomic, strong) UILabel  *valueLabel;
@property (nonatomic, strong) NSString *valueIdentifier;

@property (nonatomic, unsafe_unretained) id<EditablePageCellDelegate> delegate;

@end
