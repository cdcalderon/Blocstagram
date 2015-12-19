//
//  FilterCollectionViewCell.m
//  
//
//  Created by Lorena Calderon on 12/18/15.
//
//

#import "FilterCollectionViewCell.h"

@interface FilterCollectionViewCell () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation FilterCollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        static NSInteger imageViewTag = 1000;
        static NSInteger labelTag = 1001;
        self.thumbnail = (UIImageView *)[self.contentView viewWithTag:imageViewTag];
        self.filterlabel = (UILabel *)[self.contentView viewWithTag:labelTag];
        
        if (!self.thumbnail) {
            self.thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            self.thumbnail.contentMode = UIViewContentModeScaleAspectFill;
            self.thumbnail.tag = imageViewTag;
            self.thumbnail.clipsToBounds = YES;
            
//            self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFired:)];
//            self.tapGestureRecognizer.delegate = self;
//            //[self addGestureRecognizer:self.tapGestureRecognizer];
            
            [self.contentView addSubview:self.thumbnail];
            
        }
        
        if (!self.filterlabel) {
            self.filterlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 100, 20)];
            self.filterlabel.tag = labelTag;
            self.filterlabel.textAlignment = NSTextAlignmentCenter;
            self.filterlabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:10];
            [self.contentView addSubview:self.filterlabel];
        }
        
    }
    return self;

}

- (void) tapFired:(UITapGestureRecognizer *)sender {
    [self.delegate cell:self didTapFilterImageView:self];
}

@end
