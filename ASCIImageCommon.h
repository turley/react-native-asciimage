//
//  ASCIImageCommon.h
//
//  Created by Ben Turley on 5/29/15.
//  Copyright (c) 2015 Ben Turley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PARImage+ASCIIInput.h"

@interface ASCIImageCommon : NSObject

+ (PARImage*)imageFromASCII:(NSArray*)ascii scaleFactor:(CGFloat)scale defaultColor:(UIColor*)color contextOptions:(NSArray*)contextOptions;

@end
