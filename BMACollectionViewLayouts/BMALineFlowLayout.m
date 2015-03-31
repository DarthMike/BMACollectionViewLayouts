/*
 The MIT License (MIT)
 
 Copyright (c) 2014-present Badoo Trading Limited.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "BMALineFlowLayout.h"

@implementation BMALineFlowLayout

#pragma mark - Layout attributes override

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [self modifyAttributes:attribute];
    }
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    [self modifyAttributes:attributes];
    return attributes;
}

- (void)modifyAttributes:(UICollectionViewLayoutAttributes *)attribute {
    CGFloat originX = attribute.frame.origin.x;
    CGFloat originY = attribute.frame.origin.y;
    if (self.horizontalScroll) {
        originY = self.linePosition;
    } else {
        originX = self.linePosition;
    }
    
    attribute.frame = (CGRect){
        .origin = CGPointMake(originX, originY),
        .size = attribute.frame.size};
}

#pragma mark - Pagination

- (CGFloat)pageDimension {
    return self.scrollDirection == UICollectionViewScrollDirectionHorizontal ? self.itemSize.width + self.minimumLineSpacing : self.itemSize.height + self.minimumLineSpacing;
}

- (BOOL)horizontalScroll {
    return self.scrollDirection == UICollectionViewScrollDirectionHorizontal;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat offset = self.horizontalScroll ? self.collectionView.contentOffset.x : self.collectionView.contentOffset.y;
    CGFloat lineVelocity = self.horizontalScroll ? velocity.x : velocity.y;
    
    if (self.paginationEnabled) {
        CGFloat rawPageValue = offset / self.pageDimension;
        CGFloat currentPage = (lineVelocity > 0.0) ? floor(rawPageValue) : ceil(rawPageValue);
        CGFloat nextPage = (lineVelocity > 0.0) ? ceil(rawPageValue) : floor(rawPageValue);
        
        BOOL pannedLessThanAPage = fabs(1 + currentPage - rawPageValue) > 0.5;
        BOOL flicked = fabs(lineVelocity) > [self flickVelocity];
        CGFloat newOffset = 0;
        if (pannedLessThanAPage && flicked) {
            newOffset = nextPage * self.pageDimension;
        } else {
            newOffset = round(rawPageValue) * self.pageDimension;
        }
        
        if (self.horizontalScroll) {
            proposedContentOffset.x = newOffset;
        } else {
            proposedContentOffset.y = newOffset;
        }
        
        return proposedContentOffset;
    }
    
    return proposedContentOffset;
}

- (CGFloat)flickVelocity {
    return 0.3;
}

@end
