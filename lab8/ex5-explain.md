# Exercise 5 Explanation

Exercise 5 creates a geo-tagged photo gallery.

It combines camera, location, Hive storage, and map launching.

The app uses a `GeoPhoto` model.
Each photo stores:

- image path
- latitude
- longitude
- created date

Hive stores the photos in the `photos` box.
The screen opens the box when Exercise 5 starts.

`ValueListenableBuilder` watches the Hive box.
When photos are added or deleted, the list updates automatically.

If there are no photos, the screen shows an empty message.

The `+` button opens the selfie camera screen.
After saving a photo, the app gets the current location.
Then it stores the photo path and coordinates in Hive.

Each card shows the image, coordinates, and date.
Coordinates are shown with four decimals.

The View on Map button opens Google Maps using `url_launcher`.

Long pressing a card opens a delete dialog.
If the user confirms, `photo.delete()` removes it from Hive.
