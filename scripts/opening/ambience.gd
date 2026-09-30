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

# Authored cue timing, procedural REVIEW sound sources; no recorded voice yet.
var cues: Array = []
var cue_cursor := 0
var effects: Dictionary = {}
var effect_players: Array[AudioStreamPlayer] = []
func configure(beat: Dictionary) -> void:
	cues = beat.get("cues",[])
	cue_cursor = 0
	if effects.is_empty():
		for kind in ["warm","dread","pulse","breath","door","step"]:
			effects[kind] = make_effect(kind)
		for i in 4:
			var player := AudioStreamPlayer.new()
			add_child(player)
			effect_players.append(player)

func update_cinematic(_id: String, time: float) -> void:
	while cue_cursor < cues.size() and float(cues[cue_cursor].at) <= time:
		var kind := str(cues[cue_cursor].sound)
		cue_cursor += 1
		if kind == "depart":
			leave_vehicle()
		elif kind == "silence":
			end_cinematic()
		elif effects.has(kind):
			var player := effect_players[cue_cursor % effect_players.size()]
			player.stream = effects[kind]
			player.volume_db = -21 if kind == "step" else -15
			player.play()
	if _id == "memory":
		rain.volume_db = -24
		vehicle.volume_db = -40
	elif _id == "recover":
		rain.volume_db = -17
		vehicle.volume_db = -24
	elif _id == "stop":
		rain.volume_db = -15+smoothstep(0.5,1.5,time)*3
	else:
		rain.volume_db = -15

func end_cinematic() -> void:
	for player in effect_players:
		player.stop()

func make_effect(kind: String) -> AudioStreamWAV:
	var seconds := 0.30
	if kind == "warm":
		seconds = 4.0
	elif kind == "dread":
		seconds = 2.4
	elif kind == "breath":
		seconds = 1.15
	elif kind == "door":
		seconds = 0.7
	var stream := AudioStreamWAV.new()
	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = 22050
	var count := int(seconds*stream.mix_rate)
	var bytes := PackedByteArray()
	bytes.resize(count*2)
	var rng := RandomNumberGenerator.new()
	rng.seed = 928
	var filtered := 0.0
	for i in count:
		var t := float(i)/stream.mix_rate
		var phase := t/seconds
		var noise := rng.randf_range(-1,1)
		filtered = lerpf(filtered,noise,0.18)
		var envelope := sin(PI*phase)
		var sample := 0.0
		match kind:
			"warm":
				sample = (sin(TAU*220*t)+0.35*sin(TAU*330*t))*exp(-t)*envelope*0.25
			"dread":
				sample = (sin(TAU*53*t)+0.35*sin(TAU*57*t))*envelope*0.25
			"pulse":
				sample = sin(TAU*62*t)*exp(-phase*8)*0.5
			"breath":
				sample = filtered*envelope*1.1
			"door":
				sample = filtered*envelope*0.5+sin(TAU*(170-30*phase)*t)*envelope*0.03
			"step":
				sample = (filtered*0.6+sin(TAU*85*t)*0.1)*exp(-phase*12)
		bytes.encode_s16(i*2,int(clampf(sample,-1,1)*32767))
	stream.data = bytes
	return stream
