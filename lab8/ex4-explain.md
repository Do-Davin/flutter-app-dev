# Exercise 4 Explanation

Exercise 4 creates a live compass screen.

The screen uses the `sensors_plus` package.
It listens to `magnetometerEventStream`.

The magnetometer gives magnetic field values for x, y, and z.
The app uses x and y to calculate the heading.

The heading is stored in `_heading` as radians.

The stream uses a 50 millisecond sampling period.
This is about 20 updates per second.

The app also checks the last update time.
If updates come too quickly, it ignores them.

The heading is calculated with `math.atan2`.
The result is normalized so the value stays positive.

The compass arrow uses `Transform.rotate`.
The angle is `-_heading`.
This makes the arrow rotate toward the north direction.

The screen also shows the heading in degrees.
The value is converted from radians to degrees and kept between 0 and 359.

The stream subscription is cancelled in `dispose`.
