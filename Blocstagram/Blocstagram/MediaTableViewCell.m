//
//  MediaTableViewCell.m
//  Blocstagram
//
//  Created by Carlos Calderon on 11/8/15.
//  Copyright (c) 2015 Carlos Calderon. All rights reserved.
//

#import "MediaTableViewCell.h"
#import "Media.h"
#import "Comment.h"
#import "User.h"

@interface MediaTableViewCell ()

@property (nonatomic,strong) UIImageView *mediaImageView;
@property (nonatomic, strong) UILabel *usernameAndCaptionLabel;
@property (nonatomic, strong) UILabel *commentLabel;

@property (nonatomic, strong) NSLayoutConstraint *imageHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *imageWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *xCenterImageConstraint;
@property (nonatomic, strong) NSLayoutConstraint *usernameAndCaptionLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *commentLabelHeightConstraint;
@end

static UIFont *lightFont;
static UIFont *boldFont;
static UIColor *usernameLabelGray;
static UIColor *commentLabelGray;
static UIColor *linkColor;
static UIColor *firstCommentColor;
static NSParagraphStyle *paragraphStyle;

@implementation MediaTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.mediaImageView = [[UIImageView alloc] init];
        self.usernameAndCaptionLabel = [[UILabel alloc] init];
        self.usernameAndCaptionLabel.numberOfLines = 0;
        self.usernameAndCaptionLabel.backgroundColor = usernameLabelGray;
        
        self.commentLabel = [[UILabel alloc] init];
        self.commentLabel.numberOfLines = 0;
        self.commentLabel.backgroundColor = commentLabelGray;
        
        for(UIView *view in @[self.mediaImageView, self.usernameAndCaptionLabel, self.commentLabel]){
            [self.contentView addSubview:view];
            view.translatesAutoresizingMaskIntoConstraints = NO;
        }
        
        NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_mediaImageView, _usernameAndCaptionLabel, _commentLabel);
        //removed to allow image be centered using xCenterImageConstraint
//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_mediaImageView]|" options:kNilOptions metrics:nil views:viewDictionary]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_usernameAndCaptionLabel]|" options:kNilOptions metrics:nil views:viewDictionary]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_commentLabel]|" options:kNilOptions metrics:nil views:viewDictionary]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_mediaImageView][_usernameAndCaptionLabel][_commentLabel]" options:kNilOptions metrics:nil views:viewDictionary]];
        
        self.xCenterImageConstraint = [NSLayoutConstraint constraintWithItem:_mediaImageView
                                                                             attribute:NSLayoutAttributeCenterX
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.contentView
                                                                             attribute:NSLayoutAttributeCenterX
                                                                            multiplier:1.0
                                                                              constant:0.0];
        self.xCenterImageConstraint.identifier = @"Image centerX constraint";

        
        self.imageWidthConstraint = [NSLayoutConstraint constraintWithItem:_mediaImageView
                                                                 attribute:(NSLayoutAttributeWidth)
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1
                                                                  constant:100];
        self.imageWidthConstraint.identifier = @"Image width constraint";

        
        
        self.imageHeightConstraint = [NSLayoutConstraint constraintWithItem:_mediaImageView
                                                                  attribute:(NSLayoutAttributeHeight)
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1
                                                                   constant:100];
        self.imageHeightConstraint.identifier = @"Image height constraint";
        
        self.usernameAndCaptionLabelHeightConstraint  = [NSLayoutConstraint constraintWithItem:_usernameAndCaptionLabel
                                                                                     attribute:NSLayoutAttributeHeight
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:nil
                                                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                                                    multiplier:1
                                                                                      constant:100];
        self.usernameAndCaptionLabelHeightConstraint.identifier = @"Username and caption label height constraint";
        
        self.commentLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_commentLabel
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:100];
        self.commentLabelHeightConstraint.identifier = @"Comment label height constraint";
 
        [self.contentView addConstraints:@[self.imageHeightConstraint, self.imageWidthConstraint, self.xCenterImageConstraint, self.usernameAndCaptionLabelHeightConstraint, self.commentLabelHeightConstraint]];
        
    }
    
    return self;
}

+ (void) load {
    lightFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:11];
    boldFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:11];
    usernameLabelGray = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1]; /*#eeeeee*/
    commentLabelGray = [UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1]; /*#e5e5e5*/
    linkColor = [UIColor colorWithRed:0.345 green:0.314 blue:0.427 alpha:1]; /*#58506d*/
    firstCommentColor = [UIColor orangeColor];
    
    NSMutableParagraphStyle *mutableParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    mutableParagraphStyle.headIndent = 20.0;
    mutableParagraphStyle.firstLineHeadIndent = 20.0;
    mutableParagraphStyle.tailIndent = -20.0;
    mutableParagraphStyle.paragraphSpacingBefore = 5;
    
    paragraphStyle = mutableParagraphStyle;
}

//- (CGSize) sizeOfString:(NSAttributedString *)string {
//    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.contentView.bounds) - 40, 0.0);
//    CGRect sizeRect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
//    sizeRect.size.height += 20;
//    sizeRect = CGRectIntegral(sizeRect);
//    return sizeRect.size;
//}

- (void) layoutSubviews {
    [super layoutSubviews];
    
//    CGFloat imageHeight =  self.mediaItem.image.size.height / self.mediaItem.image.size.width * CGRectGetWidth(self.contentView.bounds);
//    self.mediaImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), imageHeight);
//    
//    CGSize sizeOfUsernameAndCaptionLabel =  [self sizeOfString:self.usernameAndCaptionLabel.attributedText];
//    self.usernameAndCaptionLabel.frame = CGRectMake(0, CGRectGetMaxY(self.mediaImageView.frame), CGRectGetWidth(self.contentView.bounds), sizeOfUsernameAndCaptionLabel.height);
//    
//    CGSize sizeOfCommentLabel =  [self sizeOfString:self.commentLabel.attributedText];
//    self.commentLabel.frame = CGRectMake(0, CGRectGetMaxY(self.usernameAndCaptionLabel.frame), CGRectGetWidth(self.bounds), sizeOfCommentLabel.height);
    
    // Before layout, calculate the intrinsic size of the labels (the size they "want" to be), and add 20 to the height for some vertical padding.
    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX);
    CGSize usernameLabelSize = [self.usernameAndCaptionLabel sizeThatFits:maxSize];
    CGSize commentLabelSize = [self.commentLabel sizeThatFits:maxSize];
    
    self.usernameAndCaptionLabelHeightConstraint.constant = usernameLabelSize.height + 20;
    self.commentLabelHeightConstraint.constant = commentLabelSize.height + 20;
//    self.imageHeightConstraint.constant = self.mediaItem.image.size.height / self.mediaItem.image.size.width * CGRectGetWidth(self.contentView.bounds);
    
    self.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(self.bounds)/2.0, 0, CGRectGetWidth(self.bounds)/2.0);
}


- (NSAttributedString *) usernameAndCaptionString {
    CGFloat usernameFontSize = 15;
    
    NSString *baseString = [NSString stringWithFormat:@"%@ %@", self.mediaItem.user.userName, self.mediaItem.caption];
    
    NSMutableAttributedString * mutableUsernameAndCaptionString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName:[lightFont fontWithSize:usernameFontSize], NSParagraphStyleAttributeName: paragraphStyle}];
    
    NSRange usernameRange = [baseString rangeOfString:self.mediaItem.user.userName];
    [mutableUsernameAndCaptionString addAttribute:NSFontAttributeName value:[boldFont fontWithSize:usernameFontSize] range:usernameRange];
    [mutableUsernameAndCaptionString addAttribute: NSForegroundColorAttributeName value: linkColor range:usernameRange];
    
    CGFloat kernSize = 3.5;
    NSRange captionRange = [baseString rangeOfString:self.mediaItem.caption];
    [mutableUsernameAndCaptionString addAttribute:NSKernAttributeName value:@(kernSize) range:captionRange];
    
     return mutableUsernameAndCaptionString;
}

- (NSAttributedString *) commentString {
    
    NSMutableAttributedString * commentString = [[NSMutableAttributedString alloc] init];
    NSUInteger commentIdex = 1;
    for (Comment *comment in self.mediaItem.comments){
        NSString *baseString = [NSString stringWithFormat:@"%@ %@\n", comment.from.userName, comment.text];
        
        NSMutableAttributedString *oneCommentString = [self getCommentAttributedString:commentIdex baseString:baseString comment:comment];

        NSRange usernameRange = [baseString rangeOfString:comment.from.userName];
        [oneCommentString addAttribute:NSFontAttributeName value:boldFont range:usernameRange];
        [oneCommentString addAttribute:NSForegroundColorAttributeName value:linkColor range:usernameRange];

        [commentString appendAttributedString:oneCommentString];
        commentIdex++;
    }
    
    return commentString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setMediaItem:(Media *)mediaItem {
    _mediaItem = mediaItem;
    self.mediaImageView.image = _mediaItem.image;
    self.usernameAndCaptionLabel.attributedText = [self usernameAndCaptionString];
    self.commentLabel.attributedText = [self commentString];
}

- (NSMutableAttributedString *) getCommentAttributedString:(NSUInteger)commentIndex baseString:(NSString *)baseString comment: (Comment *) comment {
    NSMutableAttributedString *oneCommentString;
    if(commentIndex % 2 == 0){
        NSMutableParagraphStyle *tempParagraphStyle = [paragraphStyle mutableCopy];
        tempParagraphStyle.alignment = NSTextAlignmentRight;
        tempParagraphStyle.alignment = NSTextAlignmentRight;
        oneCommentString = [[NSMutableAttributedString alloc] initWithString:baseString
                                                                  attributes:@{NSFontAttributeName: lightFont,
                                                                                                          NSParagraphStyleAttributeName : tempParagraphStyle}];
    } else {
        oneCommentString = [[NSMutableAttributedString alloc] initWithString:baseString
                                                                  attributes:@{NSFontAttributeName: lightFont,
                                                                               NSParagraphStyleAttributeName : paragraphStyle}];
    }
    
    if(commentIndex == 1){
        NSRange commentRange = [baseString rangeOfString:comment.text];
        [oneCommentString addAttribute:NSForegroundColorAttributeName value:firstCommentColor range:commentRange];
    }
    return oneCommentString;
}


+ (CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width {
    // Make cell
    MediaTableViewCell *layoutCell = [[MediaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"layoutCell"];
    
    //Give it to the Media Item
    layoutCell.mediaItem = mediaItem;
    
    layoutCell.frame = CGRectMake(0, 0, width, CGRectGetHeight(layoutCell.frame));
    
    [layoutCell setNeedsLayout];
    [layoutCell layoutIfNeeded];
    
    //gte the actual height required for the cell
    return CGRectGetMaxY(layoutCell.commentLabel.frame);
}

@end
