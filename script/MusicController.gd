extends Node


var menu_music = load("res://asset/SoundEffects/481121__jeltsinsh__ambient-game.wav")

func play_music():
	$MusicMenu.stream = menu_music
	$MusicMenu.play()

func stop_music():
	$MusicMenu.stop()
