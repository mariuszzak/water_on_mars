# WaterOnMars

To run the process sensor data you can run the following command:

```
mix water_on_mars.process_sensor_data "<<raw_sensor_data>>"
```

For example:

```
mix water_on_mars.process_sensor_data "3 4 2 3 2 1 4 4 2 0 3 4 1 1 2 3 4 4"
```

The command output will be:

```
(1, 2 score: 27)
(1, 1 score: 25)
(2, 2 score: 23)
```
