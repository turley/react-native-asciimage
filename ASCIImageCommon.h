//
//  ASCIImageCommon.h
//
//  Created by Ben Turley on 5/29/15.
//  Copyright (c) 2015 Ben Turley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PARImage+ASCIIInput.h"
#import <RCTBridgeModule.h>

@interface ASCIImageCommon : NSObject <RCTBridgeModule>

+ (PARImage*)imageFromASCII:(NSArray*)ascii scaleFactor:(CGFloat)scale defaultColor:(UIColor*)color contextOptions:(NSArray*)contextOptions;

@end
