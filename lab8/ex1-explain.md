# Exercise 1 Explanation

Exercise 1 creates a reusable expandable card widget.

The widget is named `ExpandableCard`.
It receives two values:

- `title`: the text shown in the card header
- `content`: the widget shown after expanding

The widget uses `StatefulWidget` because it needs to remember whether the card is open or closed.

The `_open` boolean starts as `false`.
When the user taps the `ListTile`, `setState` changes `_open`.

The chevron icon uses `AnimatedRotation`.
When `_open` is true, the icon rotates `0.5` turns.
That means it rotates 180 degrees.

The body uses `AnimatedCrossFade`.
When closed, it shows `SizedBox.shrink()`.
When open, it shows `widget.content`.

Both animations use 250 milliseconds and `Curves.easeInOut`.
