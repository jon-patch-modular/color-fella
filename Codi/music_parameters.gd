extends AudioStreamPlayer


@export var speed_mode : SpeedMode = SpeedMode.boring
@export var speed_ratios = {SpeedMode.boring: 1.0, SpeedMode.vapor: 0.7, SpeedMode.night: 1.2}

enum SpeedMode {boring, vapor, night}
