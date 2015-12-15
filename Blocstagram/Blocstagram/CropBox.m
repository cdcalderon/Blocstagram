//
//  CropBox.m
//  
//
//  Created by Carlos Calderon on 12/11/15.
//
//

#import "CropBox.h"

@interface CropBox ()

@property (nonatomic, strong) NSArray *horizontalLines;
@property (nonatomic, strong) NSArray *verticalLines;
@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UIToolbar *topView;
@property (nonatomic, strong) UIToolbar *bottomView;
@end

@implementation CropBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        self.topView = [UIToolbar new];
        self.bottomView = [UIToolbar new];

        UIColor *whiteBG = [UIColor colorWithWhite:1.0 alpha:.15];

        self.topView.barTintColor = whiteBG;
        self.bottomView.barTintColor = whiteBG;
        self.topView.alpha = 0.5;
        self.bottomView.alpha = 0.5;
        
        [self addSubview:self.topView];
        [self addSubview:self.bottomView];
        NSArray *lines = [self.horizontalLines arrayByAddingObjectsFromArray:self.verticalLines];
        for (UIView *lineView in lines) {
            [self addSubview:lineView];
        }
    }
    return self;
}

- (NSArray *) horizontalLines {
    if (!_horizontalLines) {
        _horizontalLines = [self newArrayOfFourWhiteViews];
    }
    
    return _horizontalLines;
}

- (NSArray *) verticalLines {
    if (!_verticalLines) {
        _verticalLines = [self newArrayOfFourWhiteViews];
    }
    
    return _verticalLines;
}

- (NSArray *) newArrayOfFourWhiteViews {
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 4; i++) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        [array addObject:view];
    }
    
    return array;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    //NOTE: Ask Falko how to access NavBar Top Layout Guide from Here, to eliminate Magic Wrong Height and Frame numbers
    CGFloat width = CGRectGetWidth(self.frame);
    self.topView.frame = CGRectMake(0, -100, width, 100);
    
    CGFloat yOriginOfBottomView = CGRectGetMaxY(self.topView.frame) + width;
    CGFloat heightOfBottomView = CGRectGetHeight(self.frame);
    self.bottomView.frame = CGRectMake(0, yOriginOfBottomView, width, heightOfBottomView);
    
    CGFloat thirdOfWidth = width / 3;
    
    for (int i = 0; i < 4; i++) {
        UIView *horizontalLine = self.horizontalLines[i];
        UIView *verticalLine = self.verticalLines[i];
        
        horizontalLine.frame = CGRectMake(0, (i * thirdOfWidth), width, 0.5);
        
        CGRect verticalFrame = CGRectMake(i * thirdOfWidth, 0, 0.5, width);
        
        if (i == 3) {
            verticalFrame.origin.x -= 0.5;
        }
        
        verticalLine.frame = verticalFrame;
    }
}
@end
