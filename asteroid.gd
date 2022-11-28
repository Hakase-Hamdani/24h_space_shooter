#script ini untuk asteroid.tscn

extends Area2D

var explosion_scene = preload("../explosion.tscn")
var move_speed = 25
var score_emitted = false
signal score
	
func _process(delta):
	position -= Vector2(move_speed * delta, 0.0) #position dari asteroid di dapat dari operasi berikut
	if position.x <= -100: #jika asteroid posisinya lebih dari x(100) maka hapus dari memori
		queue_free()

func _on_asteroid_area_entered(area): #saat ada collision yang memasuki area asteroid, fungsi ini akan dijalankan
	if area.is_in_group("shot") or area.is_in_group("player"): #jika area dari scene ini ada di dalam grup shot atau player, maka eksekusi prosedur di bawah
		if not score_emitted: #jika score_emitted false
			score_emitted = true #ubah jadi true
			emit_signal("score") #emit sinyal "score"
			print("asteroid is ok")
			queue_free() #lalu hapus asteroid dari memori
			print("hit is ok")
			
			#line di bawah mengganti asteroid dengan explosion.tscn setelah queue_free() di atas dijalankan
			var stage_node = get_parent()
			var explosion_instance = explosion_scene.instance()
			explosion_instance.position = position
			stage_node.add_child(explosion_instance)
