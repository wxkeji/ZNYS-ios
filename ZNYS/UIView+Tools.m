//
//  UIView+Tools.m
//  ZNYS
//
//  Created by 张恒铭 on 4/23/17.
//  Copyright © 2017 Woodseen. All rights reserved.
//

#import "UIView+Tools.h"

@implementation UIView (Tools)

- (CGFloat) height {
    return self.frame.size.height;
}

- (CGFloat) width {
    return self.frame.size.width;
}

- (CGFloat) left {
    return self.frame.origin.x;
}

- (CGFloat) right  {
    return self.frame.origin.x + self.frame.size.height;
}

- (CGFloat) top {
    return self.frame.origin.x;
}

- (CGFloat) bottom {
    return self.frame.origin.x + self.frame.size.height;
}
@end
