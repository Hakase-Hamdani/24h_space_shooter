#script ini untuk player.tscn

extends Area2D

const MOVE_SPEED = 150.0 #kecepatan pemain dalam piksel/detik
const SCREEN_WIDTH = 320 #lebar layar
const SCREEN_HEIGHT = 180 #tinggi layar

var shot_scene = preload("../shot.tscn") #load scene di sini sebagai variable
var explosion_scene = preload("../explosion.tscn")

var can_shoot = true #teapkan nilai awal variable, jika ini bernilai true di dalam function, maka shot.gd bisa di jalankan

var destroy_emitted = false
signal destroyed

func _process(delta):
	var input_dir = Vector2() #input di terima dari operasi Vector2()

	if Input.is_key_pressed(KEY_UP):
		input_dir.y -= 1.0
	if Input.is_key_pressed(KEY_DOWN):
		input_dir.y += 1.0
	if Input.is_key_pressed(KEY_LEFT):
		input_dir.x -= 1.0
	if Input.is_key_pressed(KEY_RIGHT):
		input_dir.x += 1.0
		
	position += (delta * MOVE_SPEED) * input_dir
	#position di dapat dari operasi (delta * MOVE_SPEED) * input_dir
	#dimana input_dir di dapat dari operasi logika if di atas
	#dimana position bawaan dari engine
	
	if position.x < 0.0: # jika position di bawah 0
		position.x = 0.0 # maka buat position menjadi 0 untuk menghentikan player
	elif position.x > SCREEN_WIDTH: # jika position diatas SCREEN_WIDTH
		position.x = SCREEN_WIDTH # maka tetapkan position sebagai SCREEN_WIDTH agar player tetap berjalan
	if position.y < 0.0:
		position.y = 0.0
	elif position.y > SCREEN_HEIGHT:
		position.y = SCREEN_HEIGHT
		
	if Input.is_key_pressed(KEY_SPACE) and can_shoot: #jika tombol spasi di tekan
		can_shoot = false #buat nilai can_shoot menjadi false, mencegah shot.gd dijalankan
		get_node("reload_timer").start() #jalankan hitung mundur di node reload_timer
		
		var stage_node = get_parent() #buat variabel dengan melakukan get_parent, yaitu membuat variabel yang berisi parent node (ship.tscn)
		
		var shot_instance1 = shot_scene.instance() #buat variable shot_instance dari variabel shot_scene dengan instancing(?)
		var shot_instance2 = shot_scene.instance()
		
		var shot1 = Vector2(9,-5) #dua variabel ini untuk menentukan posisi spawn laser
		var shot2 = Vector2(9,5)
		
		shot_instance1.position = position+shot1 #posisi shot_instance harus sama dengan position func _process(delta) + variabel shot1
		shot_instance2.position = position+shot2
		
		stage_node.add_child(shot_instance1) #tambahkan shot.tscn sebagai child dari ship.tscn
		stage_node.add_child(shot_instance2)

func _on_reload_timer_timeout():
	can_shoot = true #saat reload_timer habis hitung mundur, buat can_shoot menjadi true


func _on_player_area_entered(area):
	if area.is_in_group("asteroid"):
		if not destroy_emitted: #jika destroy_emitted false
			destroy_emitted = true #jadikan true
			emit_signal("destroyed") #emit sinyal "destroyed"
			queue_free() #hapus dari memori
			
			#line di bawah mengganti ship dengan explosion.tscn setelah queue_free() di atas dijalankan
			var stage_node = get_parent()
			var explosion_instance = explosion_scene.instance()
			explosion_instance.position = position
			stage_node.add_child(explosion_instance)
