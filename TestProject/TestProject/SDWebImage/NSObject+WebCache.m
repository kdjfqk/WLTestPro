//
//  NSObject+WebCache.m
//  BWA_APP
//
//  Created by dongkui on 8/16/16.
//  Copyright © 2016 baidu. All rights reserved.
//

#import "NSObject+WebCache.h"
#import "objc/runtime.h"

static char operationKey;

@implementation NSObject (WebCache)

- (BOOL)invokeSetImage:(UIImage *)image
{
    SEL setImageSel = @selector(setImage:);
    if (![self respondsToSelector:setImageSel]) {
        return NO;
    }
    NSMethodSignature*signature = [self methodSignatureForSelector:setImageSel];
    if (signature == nil) {
        return NO;
    }
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = setImageSel;
    [invocation setArgument:&image atIndex:2];
    [invocation invoke];
    return YES;
}

#pragma mark - Interfaces
- (void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url placeholderImage:nil progress:nil completed:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self setImageWithURL:url placeholderImage:placeholder progress:nil completed:nil];
}

- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionWithFinishedBlock)completedBlock
{
    [self setImageWithURL:url placeholderImage:nil progress:nil completed:completedBlock];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionWithFinishedBlock)completedBlock
{
    [self setImageWithURL:url placeholderImage:placeholder progress:nil completed:completedBlock];
}

- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholder
               progress:(SDWebImageDownloaderProgressBlock)progressBlock
              completed:(SDWebImageCompletionWithFinishedBlock)completedBlock
{
    [self cancelCurrentImageLoad];
    if (![self invokeSetImage:placeholder]) {
        NSLog(@"%@ does not response to selector 'setImage:'", self);
        return;
    }

    if (url) {
        __weak NSObject *wself = self;
        id <SDWebImageOperation> operation = [SDWebImageManager.sharedManager
                                              downloadImageWithURL:url
                                              options:0
                                              progress:progressBlock
                                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!wself) return;
            dispatch_main_sync_safe(^{
                if (!wself) return;
                if (image) {
                    [wself invokeSetImage:image];
                }
                if (completedBlock && finished) {
                    completedBlock(image, error, cacheType, finished, imageURL);
                }
            });
        }];
        objc_setAssociatedObject(self, &operationKey, operation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)cancelCurrentImageLoad
{
    id <SDWebImageOperation> operation = objc_getAssociatedObject(self, &operationKey);
    if (operation) {
        [operation cancel];
        objc_setAssociatedObject(self, &operationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

@end
