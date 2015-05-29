//
//  RCTASCIImageManager.m
//
//  Created by Ben Turley on 5/10/15.
//  Copyright (c) 2015 Ben Turley. All rights reserved.
//

#import "RCTASCIImageManager.h"

#import "ASCIImage.h"


@implementation RCTASCIImageManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
    return [[ASCIImage alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(ascii, NSStringArray)
RCT_EXPORT_VIEW_PROPERTY(color, UIColor)
RCT_EXPORT_VIEW_PROPERTY(contextOptions, NSArray)

@end
