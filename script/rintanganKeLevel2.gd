extends Node2D


func _on_Press_platform_spike_off():
	$spikeFloor.spikeActive = true
	$spikeFloor2.spikeActive = true
	$spikeFloor3.spikeActive = true
	$spikeFloor4.spikeActive = true
