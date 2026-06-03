# Exercise 3 Explanation

Exercise 3 creates a selfie camera screen.

The screen uses the `camera` package.
It stores a nullable `CameraController`.
It also stores `_capturedPath`, which is the saved path of the photo.

In `initState`, the app calls `availableCameras()`.
It tries to find the front camera using `CameraLensDirection.front`.

The camera controller uses `ResolutionPreset.medium`.
Audio is disabled because this exercise only needs photos.

If no photo is captured yet, the screen shows `CameraPreview`.
It also shows a shutter button.

When the shutter button is tapped, `takePicture()` captures the image.
The returned file path is stored in `_capturedPath`.

After a photo is captured, the screen shows `Image.file`.
It also shows Retake and Save buttons.

Retake clears `_capturedPath`.
Save copies the photo into the app documents directory.

After saving, the screen uses `Navigator.pop` and returns the saved path.

The controller is disposed in `dispose` to release the camera.
