//
//  ASCIImageWriter.m
//
//  Created by Ben Turley on 5/28/15.
//  Copyright (c) 2015 Ben Turley. All rights reserved.
//

#import "ASCIImageWriter.h"
#import "ASCIImageCommon.h"
#import "PARImage+ASCIIInput.h"
#import "RCTConvert.h"
#import <CommonCrypto/CommonDigest.h>

@implementation ASCIImageWriter

RCT_EXPORT_MODULE()


RCT_EXPORT_METHOD(createImageFromASCII:(NSArray*)ascii withColor:(UIColor*)color width:(NSInteger)imageWidth callback:(RCTResponseSenderBlock)imageURLCallback)
{
    [self createImageFromASCIIWithOptions:ascii withColor:color width:imageWidth contextOptions:nil callback:imageURLCallback];
}

RCT_EXPORT_METHOD(createImageFromASCIIWithOptions:(NSArray*)ascii withColor:(UIColor*)color width:(NSInteger)imageWidth contextOptions:(NSArray*)contextOptions callback:(RCTResponseSenderBlock)imageURLCallback)
{
    NSString *supportDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    supportDirectory = [supportDirectory stringByAppendingPathComponent:@"ASCIImageCache"];
    [self checkDirectory:supportDirectory];
    
    NSArray *strictRep = [PARImage strictASCIIRepresentationFromLenientASCIIRepresentation:ascii];
    NSString *baseImagePath = nil;
    
    NSDictionary *sizes = @{@"" : @(1.0), @"@2x" : @(2.0), @"@3x" : @(3.0) };
    for (NSString *key in [sizes allKeys]) {
        NSString *filename = [self fileNameForASCII:strictRep withColor:color width:imageWidth contextOptions:contextOptions suffix:key];
        NSString *imagePath = [supportDirectory stringByAppendingPathComponent:filename];
        if ([[sizes objectForKey:key] floatValue] == 1.0) {
            baseImagePath = imagePath;
        }
        
        // Only generate/create image if it doesn't already exist
        if (![[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
            CGFloat actualSize = imageWidth * [[sizes objectForKey:key] floatValue];
            CGFloat scale = 1.0;
            if (strictRep != nil) {
                scale = actualSize / [strictRep.firstObject length];
            }
            
            UIImage *image = [ASCIImageCommon imageFromASCII:strictRep scaleFactor:scale defaultColor:color contextOptions:contextOptions];
            [[NSFileManager defaultManager] createFileAtPath:imagePath contents:UIImagePNGRepresentation(image) attributes:nil];
        }
    }
    
    imageURLCallback(@[ baseImagePath ]);
}

- (void)checkDirectory:(NSString*)directory
{
    // If directory doesn't exist
    if (![[NSFileManager defaultManager] fileExistsAtPath:directory isDirectory:NULL]) {
        NSError *error = nil;
        
        // Create directory
        if (![[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"%@", error.localizedDescription);
        }
    }
}

- (NSString*)fileNameForASCII:(NSArray*)ascii withColor:(UIColor*)color width:(NSInteger)imageWidth contextOptions:(NSArray*)contextOptions suffix:(NSString*)suffix
{
    NSData *jsonContextOptions = [NSJSONSerialization dataWithJSONObject:contextOptions options:0 error:NULL];
    
    NSArray *key = @[
                     [ascii componentsJoinedByString:@"\n"],
                     [self hexStringFromColor:color],
                     [[NSString alloc] initWithData:jsonContextOptions encoding:NSUTF8StringEncoding],
                     [NSString stringWithFormat:@"%ld", imageWidth]
                     ];
    return [NSString stringWithFormat:@"%@%@.png", [self md5:[key componentsJoinedByString:@"|"]], suffix];
}



- (NSString*)md5:(NSString*)inputString
{
    const char *cstr = [inputString UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (unsigned int)strlen(cstr), result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString*)hexStringFromColor:(UIColor *)color
{
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}

@end