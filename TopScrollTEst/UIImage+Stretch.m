//
//  UIImage+Stretch.m
//

#import "UIImage+Stretch.h"

@implementation UIImage (Stretch)

- (UIImage *)centerStretchableImage
{
	return [self stretchableImageWithLeftCapWidth:(self.size.width/2.0f) topCapHeight:(self.size.height/2.0f)];
}

@end
