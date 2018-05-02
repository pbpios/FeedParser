//
//  FeedTableViewCell.m
//  FeedParser
//
//  Created by Prashant on 4/26/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import "FeedTableViewCell.h"
#import "BaseDataTransfer.h"
@implementation FeedTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.feedImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.feedImageView];
        self.feedImageView.translatesAutoresizingMaskIntoConstraints = NO;

        NSLayoutConstraint *imageViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.feedImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50];
        NSLayoutConstraint *imageViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.feedImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50];
        NSLayoutConstraint *imageViewLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.feedImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.feedImageView.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:5];
        NSLayoutConstraint *imageViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.feedImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:5];
        [NSLayoutConstraint activateConstraints:@[ imageViewWidthConstraint, imageViewHeightConstraint, imageViewLeadingConstraint, imageViewTopConstraint ]];

        self.feedTitleLabel = [[UILabel alloc] init];
        [self.feedTitleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [self.feedTitleLabel setNumberOfLines:0];
        [self.feedTitleLabel setTextColor:[UIColor blackColor]];
        [self.feedTitleLabel setBackgroundColor:[UIColor whiteColor]];
        [self.feedTitleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self.feedTitleLabel sizeToFit];
        self.feedTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.feedTitleLabel];

        NSLayoutConstraint *feedTitleLabelLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.feedTitleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.feedImageView attribute:NSLayoutAttributeTrailing multiplier:1 constant:5];
        NSLayoutConstraint *feedTitleLabelTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.feedTitleLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.feedTitleLabel.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:5];
        NSLayoutConstraint *feedTitleLabelTopConstraint = [NSLayoutConstraint constraintWithItem:self.feedTitleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.feedTitleLabel.superview attribute:NSLayoutAttributeTop multiplier:1 constant:5];
        [NSLayoutConstraint activateConstraints:@[feedTitleLabelLeadingConstraint, feedTitleLabelTrailingConstraint, feedTitleLabelTopConstraint]];

        self.feedDescriptionLabel = [[UILabel alloc] init];
        [self.feedDescriptionLabel setFont:[UIFont systemFontOfSize:16]];
        [self.feedDescriptionLabel setNumberOfLines:0];
        [self.feedDescriptionLabel setTextColor:[UIColor darkGrayColor]];
        [self.feedDescriptionLabel setBackgroundColor:[UIColor whiteColor]];
        [self.feedDescriptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
        self.feedDescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.feedDescriptionLabel];

        NSLayoutConstraint *feedDescriptionLabelLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.feedDescriptionLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.feedImageView attribute:NSLayoutAttributeTrailing multiplier:1 constant:5];
        NSLayoutConstraint *feedDescriptionLabelTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.feedDescriptionLabel.superview attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.feedDescriptionLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:20];
        NSLayoutConstraint *feedDescriptionLabelTopConstraint = [NSLayoutConstraint constraintWithItem:self.feedDescriptionLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.feedTitleLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:5];
        [feedDescriptionLabelTopConstraint setPriority:250];
        NSLayoutConstraint *feedDescriptionLabelBottomConstraint = [NSLayoutConstraint constraintWithItem:self.feedDescriptionLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.feedDescriptionLabel.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [NSLayoutConstraint activateConstraints:@[ feedDescriptionLabelLeadingConstraint, feedDescriptionLabelTrailingConstraint, feedDescriptionLabelTopConstraint, feedDescriptionLabelBottomConstraint ]];
    }
    return self;
}

- (void)setFeedData:(Feed *)feedDataObject {
    [self.feedTitleLabel setText:feedDataObject.titleString];
    [self.feedDescriptionLabel setText:feedDataObject.descriptionString];
    if (feedDataObject.imageURLString.length > 0) {
        NSURL *url = [NSURL URLWithString:feedDataObject.imageURLString];
        __weak __typeof(self) weakSelf = self;

        [self downloadImageWithURL:url
                   completionBlock:^(BOOL succeeded, UIImage *image) {
                     if (succeeded) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                           [weakSelf.feedImageView setImage:image];
                         });
                     }
                   }];
    }
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
      NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                           completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
                                                             if (!error) {
                                                                 data = [NSData dataWithContentsOfURL:url];
                                                                 UIImage *image = [[UIImage alloc] initWithData:data];
                                                                 completionBlock(YES, image);
                                                             } else {
                                                                 completionBlock(NO, nil);
                                                             }
                                                           }];
      [task resume];
    });
}

@end
