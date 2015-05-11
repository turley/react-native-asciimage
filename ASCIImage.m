//
//  ASCIImage.m
//
//  Created by Ben Turley on 5/10/15.
//  Copyright (c) 2015 Ben Turley. All rights reserved.
//

#import "ASCIImage.h"
#import "PARImage+ASCIIInput.h"

#define DEFAULT_COLOR [UIColor blackColor]
#define OBSERVED_KEYS @[NSStringFromSelector(@selector(ascii)), NSStringFromSelector(@selector(color))]

@interface ASCIImage () {
    UIImageView *_imageView;
}

@property (nonatomic, strong) NSArray *ascii;
@property (nonatomic, strong) UIColor *color;

@end

@implementation ASCIImage


- (instancetype)init
{
    self = [super init];
    if (self) {
        for (NSString *key in OBSERVED_KEYS) {
            [self addObserver:self forKeyPath:key options:0 context:nil];
        }
        
        self.color = DEFAULT_COLOR;
        _imageView = [[UIImageView alloc] init];
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
    [_imageView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_imageView setImage:[PARImage imageWithASCIIRepresentation:_ascii scaleFactor:[self bestScale] color:self.color shouldAntialias:YES]];
}

- (CGFloat)bestScale
{
    NSUInteger imgWidth = 0;
    if (self.ascii != nil && self.ascii.firstObject != nil) imgWidth = [(NSString*)self.ascii.firstObject length];
    return (ceil(self.frame.size.width / imgWidth) + 1.0) * [UIScreen mainScreen].scale;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.frame;
    if ((frame.size.width <= 0 || frame.size.height <= 0) && self.ascii != nil && self.ascii.firstObject != nil) {
        frame.size.width = [(NSString*)self.ascii.firstObject length];
        frame.size.height = [self.ascii count];
        self.frame = frame;
    }
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
