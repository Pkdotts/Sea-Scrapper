extends Control

#func play_music()
var musicVolume = 0

func _ready():
	pass
	#$AudioPlayers/GameMusic.volume_db = musicVolume
	#$AudioPlayers/Ambiance.volume_db = musicVolume

func play_game_music():
	pass
	#$AudioPlayers/GameMusic.play()

func stop_game_music():
	pass
	#$AudioPlayers/GameMusic.stop()

func play_ambiance_music():
	pass
	#$AudioPlayers/Ambiance.play()

func stop_ambiance_music():
	pass
	#$AudioPlayers/Ambiance.stop()

func set_audio_pitch(speed):
	for soundEffect in $Sfx.get_children():
		soundEffect.pitch_scale = speed

func set_sfx_pitch(name, pitch):
	var sfx_node: AudioStreamPlayer = get_sfx(name)
	if sfx_node:
		sfx_node.pitch_scale = pitch

func add_sfx(stream, name) -> AudioStreamPlayer:
	var sfx_node: AudioStreamPlayer = get_sfx(name)
	if !sfx_node:
		sfx_node = AudioStreamPlayer.new()
		sfx_node.bus = "SFX"
		sfx_node.name = name
		$Sfx.add_child(sfx_node)
		
	sfx_node.stream = stream
	return sfx_node

func play_sfx(stream, name):
	var sfx_node: AudioStreamPlayer = add_sfx(stream, name)
	sfx_node.play()
	#return sfx_node

func get_sfx(name) -> AudioStreamPlayer:
	return $Sfx.get_node_or_null(name) as AudioStreamPlayer
