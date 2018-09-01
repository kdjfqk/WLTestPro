//
//  NSObject+WebCache.h
//  BWA_APP
//
//  Created by dongkui on 8/16/16.
//  Copyright © 2016 baidu. All rights reserved.
//

#import "SDWebImageCompat.h"
#import "SDWebImageManager.h"

@interface NSObject (WebCache)

/**
 * Set the image with an `url` for the object which responds to selector `setImage:`.
 *
 * The downloand is asynchronous and cached.
 *
 * @param url The url for the image.
 */
- (void)setImageWithURL:(NSURL *)url;

/**
 * Set the image with an `url` for the object which responds to selector `setImage:`.
 *
 * The downloand is asynchronous and cached.
 *
 * @param url The url for the image.
 * @param placeholder The image to be set initially, until the image request finishes.
 * @see setImageWithURL:placeholderImage:options:
 */
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

/**
 * Set the image with an `url` for the object which responds to selector `setImage:`.
 *
 * The downloand is asynchronous and cached.
 *
 * @param url The url for the image.
 * @param completedBlock A block called when operation has been completed. This block as no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrived from the local cache of from the network.
 */
- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionWithFinishedBlock)completedBlock;

/**
 * Set the image with an `url` for the object which responds to selector `setImage:`.
 *
 * The downloand is asynchronous and cached.
 *
 * @param url The url for the image.
 * @param placeholder The image to be set initially, until the image request finishes.
 * @param completedBlock A block called when operation has been completed. This block as no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrived from the local cache of from the network.
 */
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionWithFinishedBlock)completedBlock;

/**
 * Set the image with an `url` for the object which responds to selector `setImage:`.
 *
 * The downloand is asynchronous and cached.
 *
 * @param url The url for the image.
 * @param placeholder The image to be set initially, until the image request finishes.
 * @param progressBlock A block called while image is downloading
 * @param completedBlock A block called when operation has been completed. This block as no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrived from the local cache of from the network.
 */
- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholder
               progress:(SDWebImageDownloaderProgressBlock)progressBlock
              completed:(SDWebImageCompletionWithFinishedBlock)completedBlock;

/**
 * Cancel the current download
 */
- (void)cancelCurrentImageLoad;

@end
