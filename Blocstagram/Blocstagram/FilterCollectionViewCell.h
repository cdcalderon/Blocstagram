//
//  FilterCollectionViewCell.h
//  
//
//  Created by Lorena Calderon on 12/18/15.
//
//

#import <UIKit/UIKit.h>

@class FilterCollectionViewCell;

@protocol FilterCollentionViewCellDelegate <NSObject>

- (void) cell:(FilterCollectionViewCell *)cell didTapFilterImageView:(FilterCollectionViewCell *)cell;

@end

@interface FilterCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) id <FilterCollentionViewCellDelegate> delegate;
@property (nonatomic, strong) UIImageView *thumbnail;
@property (nonatomic, strong) UILabel *filterlabel;

@end

