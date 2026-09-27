extends Node
# Technical procedural sound placeholder, continuous across all transitions.
var rain: AudioStreamPlayer
var vehicle: AudioStreamPlayer
func _ready() -> void:
	rain = make_loop(false)
	vehicle = make_loop(true)
	rain.volume_db = -15
	vehicle.volume_db = -24
	rain.play()
	vehicle.play()
func make_loop(engine: bool) -> AudioStreamPlayer:
	var stream := AudioStreamWAV.new()
	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = 22050
	stream.loop_mode = AudioStreamWAV.LOOP_FORWARD
	stream.loop_end = 22050*4
	var bytes := PackedByteArray()
	bytes.resize(stream.loop_end*2)
	var rng := RandomNumberGenerator.new()
	rng.seed = 43 if engine else 42
	var low := 0.0
	for i in stream.loop_end:
		var noise := rng.randf_range(-1,1)
		low = lerpf(low,noise,0.14)
		var sample := low*0.6 + noise*0.13
		if engine:
			sample = sin(TAU*55*i/22050.0)*0.27 + sin(TAU*83*i/22050.0)*0.1 + low*0.08
		bytes.encode_s16(i*2,int(clampf(sample,-1,1)*32767))
	stream.data = bytes
	var audio := AudioStreamPlayer.new()
	audio.stream = stream
	add_child(audio)
	return audio
func leave_vehicle() -> void:
	var tween := create_tween()
	tween.tween_property(vehicle,"volume_db",-65.0,2.0)
	tween.tween_callback(vehicle.stop)
