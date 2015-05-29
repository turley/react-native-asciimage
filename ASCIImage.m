//
//  ASCIImage.m
//
//  Created by Ben Turley on 5/10/15.
//  Copyright (c) 2015 Ben Turley. All rights reserved.
//

#import "ASCIImage.h"
#import "ASCIImageCommon.h"

#define OBSERVED_KEYS @[NSStringFromSelector(@selector(ascii)), NSStringFromSelector(@selector(color)), NSStringFromSelector(@selector(contextOptions))]

@interface ASCIImage () {
    UIImageView *_imageView;
}

@property (nonatomic, strong) NSArray *ascii;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSArray *contextOptions;

@end

@implementation ASCIImage


- (instancetype)init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        for (NSString *key in OBSERVED_KEYS) {
            [self addObserver:self forKeyPath:key options:0 context:nil];
        }
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:_imageView];
        
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setNeedsLayout];
}

- (void)updateASCIImage
{
    [_imageView setFrame:self.bounds];
    [_imageView setImage:[ASCIImageCommon imageFromASCII:_ascii scaleFactor:[self bestScale] defaultColor:_color contextOptions:_contextOptions]];
}

- (CGFloat)bestScale
{
    NSArray *strictRep = [PARImage strictASCIIRepresentationFromLenientASCIIRepresentation:self.ascii];
    
    if (strictRep != nil) {
        NSUInteger imgWidth = [(NSString*)strictRep.firstObject length] * [UIScreen mainScreen].scale;
        return (ceil(self.frame.size.width / imgWidth) + 1.0) * [UIScreen mainScreen].scale;
    }
    return [UIScreen mainScreen].scale;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateASCIImage];
}

- (void) dealloc
{
    for (NSString *key in OBSERVED_KEYS) {
        @try {
            [self removeObserver:self forKeyPath:key];
        }
        @catch (NSException * __unused exception) {}
    }
}

@end
