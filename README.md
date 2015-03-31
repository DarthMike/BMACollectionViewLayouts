[![Build Status](https://travis-ci.org/badoo/BMACollectionViewLayouts.svg?branch=master)](https://travis-ci.org/badoo/BMACollectionViewLayouts)

# BMACollectionViewLayouts

A set of UICollectionView subclasses for all your layouting needs.

##Installing
You can use cocoapods, importing BMACollectionViewLayouts:
```ruby
pod 'BMACollectionViewLayouts'
```

You can also import this repository as a submodule and use the classes under 'Source' subdirectory.

##The Layouts
There is only one layout at the moment, but more are coming :rocket:

##BMAReorderableFlowLayout
This is a flow layout subclass, and allows user to drag and drop the elements inside the collection view.

The layout gives callbacks for all events in time during this interaction, and lets you control if the whole reordering is available for a single or all cells.

```objectivec
/// Return YES if the item can be dragged. Default assumed NO.
- (BOOL)collectionView:(UICollectionView *)collectionView canDragItemAtIndexPath:(NSIndexPath *)indexPath;

/// Return YES if the item can be moved from the position to the position. Default assumed NO.
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemFromIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath;

/// Reported if item can be moved, after animation happened
- (void)collectionView:(UICollectionView *)collectionView didMoveItemFromIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath;

/// Notifies that a cell has been selected and will begin dragging it
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath;

/// Notifies that a cell has been selected and did begin dragging it. Called after animations before dragging
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath;

/// Notifies that a cell previously being dragged will end dragging
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath;

/// Notifies that a cell previously dragged has been dropped to it's destination. Called after all animations.
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath;

```

A useful feature is the ability to hook in the animation of the actual cell being dragged. It is generally necessary to indicate visually that the collection view is letting the user to drag the cell, but the design should be up to you. So there are two callbacks you can implement for that effect:

```objectivec
/// Gives possibility to customise the animation of the cell when it's selected for dragging
- (BMAReorderingAnimationBlock)animationForDragBeganInCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout;

/// Gives possibility to customise the animation of the cell when it's dropped after dragging
- (BMAReorderingAnimationBlock)animationForDragEndedInCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout;

```

An example of a simple pop-out animation:
```objectivec
- (BMAReorderingAnimationBlock)animationForDragBeganInCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout {
    return ^(UICollectionViewCell *draggedView){
        draggedView.transform = CGAffineTransformMakeScale(1.3, 1.3);
    };
}

- (BMAReorderingAnimationBlock)animationForDragEndedInCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout {
    return ^(UICollectionViewCell *draggedView){
        draggedView.transform = CGAffineTransformIdentity;
    };
}
```

And how it looks like:

![image](demoimages/popinreorder.gif)

###Important

The layout needs to copy the cell in order to create a view it can move around. It does this instead of creating the snapshot, as you may want to reconfigure your cell for dragging before it actually moves. So you need to implement NSCopying in your cell and return a valid copy.


##BMALineFlowLayout
This is a flow layout subclass and it is used to display a line of elements. For the horizontal scrolling case, this happens when the elements height are more than half the collection view ``contensize.height``.

It implements features often needed for simple flow layout subclasses:

- Pagination, with smaller-than-page elements: This is not so straighforward to implement right, see http://stackoverflow.com/questions/13492037/targetcontentoffsetforproposedcontentoffsetwithscrollingvelocity-without-subcla/22238385#22238385


- Controlling line position: By default, when items flow in one line, UICollectionViewFlowLayout will position them in the middle of the contentSize. To change this and control where that line is, you can change a property in the layout.

This layout looks like this:

![image](demoimages/linelayout.gif)

