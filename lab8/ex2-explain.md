# Exercise 2 Explanation

Exercise 2 creates a photo gallery with Hero animation.

The gallery screen receives a list of image URLs.
It uses `GridView.builder` to show the images in a grid.

The grid uses `crossAxisCount: 3`.
That means each row shows three images.

Each image is wrapped with a `Hero`.
The Hero tag uses the image index, like `img-0`, `img-1`, and so on.

When the user taps an image, the app opens `DetailScreen`.
The same URL and Hero tag are passed to the detail screen.

Because the gallery image and detail image use the same Hero tag, Flutter animates the image between both screens.

The detail screen uses `InteractiveViewer`.
This lets the user zoom and pan the image.

The close button calls `Navigator.pop`.
When the screen closes, the Hero animation moves the image back to the grid.
