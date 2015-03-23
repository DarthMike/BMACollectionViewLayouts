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

@import UIKit;

/*!
 *  @abstract Lays out elements in a line, as a flow layout would do, but you can adjust the line position.
 *
 *  @discussion UICollectionViewFlowLayout lays out elements in line in the middle of content in collectionView. With this layout,
 *  you can also adjust where that line is positioned. 
 *
 *  Another feature of this layout is the correct handling of pagination, when the elements are smaller than the page size.
 */
@interface BMALineFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) NSNumber *linePosition;

@property (nonatomic, getter=isPaginationEnabled) BOOL paginationEnabled;
@property (nonatomic, readonly) CGFloat pageDimension;

@end
