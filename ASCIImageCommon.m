//
//  ASCIIImageCommon.m
//
//  Created by Ben Turley on 5/29/15.
//  Copyright (c) 2015 Ben Turley. All rights reserved.
//

#import "ASCIImageCommon.h"
#import "RCTConvert.h"

#define DEFAULT_COLOR [UIColor blackColor]

typedef enum {
    kASCIIContextFillColor = 0,
    kASCIIContextStrokeColor,
    kASCIIContextLineWidth,
    kASCIIContextShouldClose,
    kASCIIContextShouldAntialias
} ASCIIContextKey;

@implementation ASCIImageCommon


+ (PARImage*)imageFromASCII:(NSArray*)ascii scaleFactor:(CGFloat)scale defaultColor:(UIColor*)color contextOptions:(NSArray*)contextOptions
{
    return [PARImage imageWithASCIIRepresentation:ascii scaleFactor:scale contextHandler:^(NSMutableDictionary *context) {
        // Default context options
        UIColor *defaultColor = (color == nil) ? DEFAULT_COLOR : color;
        [context setObject:defaultColor forKey:ASCIIContextFillColor];
        [context setObject:defaultColor forKey:ASCIIContextStrokeColor];
        [context setObject:[NSNumber numberWithFloat:1.0] forKey:ASCIIContextLineWidth];
        [context setObject:[NSNumber numberWithBool:TRUE] forKey:ASCIIContextShouldClose];
        [context setObject:[NSNumber numberWithBool:TRUE] forKey:ASCIIContextShouldAntialias];
        
        // Override context options from user-supplied values
        if (contextOptions != nil) {
            NSInteger shapeIndex = [[context objectForKey:ASCIIContextShapeIndex] integerValue];
            NSDictionary *optionsDict = (shapeIndex < [contextOptions count]) ? [contextOptions objectAtIndex:shapeIndex] : nil;
            if (optionsDict != nil && [optionsDict isKindOfClass:[NSDictionary class]]) {
                
                for (NSString *key in [optionsDict allKeys]) {
                    
                    id optionValue = [optionsDict valueForKey:key];
                    if (optionValue != nil) {
                        switch ([[[self contextKeyMap] objectForKey:[[self javascriptKeyMap] objectForKey:key]] integerValue]) {
                            case kASCIIContextFillColor:
                            case kASCIIContextStrokeColor:
                                [context setObject:[RCTConvert UIColor:optionValue] forKey:[[self javascriptKeyMap] objectForKey:key]];
                                break;
                            case kASCIIContextLineWidth:
                            case kASCIIContextShouldClose:
                            case kASCIIContextShouldAntialias:
                                [context setObject:[RCTConvert NSNumber:optionValue] forKey:[[self javascriptKeyMap] objectForKey:key]];
                                break;
                        }
                    }
                }
            }
        }
        
    }];
}

+ (NSDictionary*)contextKeyMap
{
    return @{
             ASCIIContextFillColor : @(kASCIIContextFillColor),
             ASCIIContextStrokeColor : @(kASCIIContextStrokeColor),
             ASCIIContextLineWidth : @(kASCIIContextLineWidth),
             ASCIIContextShouldClose : @(kASCIIContextShouldClose),
             ASCIIContextShouldAntialias : @(kASCIIContextShouldAntialias)
             };
}

+ (NSDictionary*)javascriptKeyMap
{
    return @{
             @"fillColor" : ASCIIContextFillColor,
             @"strokeColor" : ASCIIContextStrokeColor,
             @"lineWidth" : ASCIIContextLineWidth,
             @"shouldClose" : ASCIIContextShouldClose,
             @"shouldAntialias" : ASCIIContextShouldAntialias
             };
}

@end
