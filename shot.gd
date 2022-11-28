extends Area2D

const SCREEN_WIDTH = 320
const MOVE_SPEED = 20.0

func _process(delta):
	position += Vector2(MOVE_SPEED +  delta, 0.0)
	# position di dapat dari operasi Vector2 dimana operasinya adalah MOVEMENT_SPEED + delta, 0.0 yang kemudian di operasikan dengan Vector2
	
	if position.x >= SCREEN_WIDTH + 8: #jika position dari node di atas atau samadengan SCREEN_WIDTH horizontal
		queue_free() #maka hapus laser dari memori


func _on_shot_area_entered(area): #saat area scene ini memasuki area lain, fungsi ini akan di jalankan
	if area.is_in_group("asteroid"): #jika area scene ini memasuki area grup asteroid, lakukan operasi di bawah
		queue_free() #hapus dari memori
