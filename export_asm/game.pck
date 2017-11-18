GDPC                                                                                 <   res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex�'      �      �Q!����|M�   res://Part.gd   �      .       1�Gm�aZ��!Y�)��   res://Parts/Part.tscn                ���^e�4�E��?:   res://Player.gd @      �      N�<`~f�Y��;��Z�   res://Player.tscn   �
      �      w�&�	t��X�IV�X-   res://Tiles/Box.tscn�      �      �ЩKSį	��p�-Z   res://World.gd               20�@�X�}׎��k   res://World.tscn       Y       ���Z���ɷ�+u�   res://default_env.tres  �      
      �?�թ+Ev�/h�!b�   res://icon.png.import   p5      �      �5Om��'�����MU��   res://project.binary07      \      3��:�Vj�7M�4            extends StaticBody2D
export var difficulty = 1  [gd_scene load_steps=6 format=2]

[ext_resource path="res://Part.gd" type="Script" id=1]
[ext_resource path="res://icon.png" type="Texture" id=2]

[sub_resource type="Gradient" id=2]

offsets = PoolRealArray( 0, 1 )
colors = PoolColorArray( 1, 1, 1, 1, 1, 1, 1, 1 )

[sub_resource type="GradientTexture" id=3]

gradient = SubResource( 2 )
width = 2048

[sub_resource type="RectangleShape2D" id=1]

custom_solver_bias = 0.0
extents = Vector2( 862.515, 10 )

[node name="Part" type="StaticBody2D"]

input_pickable = false
collision_layer = 1
collision_mask = 1
constant_linear_velocity = Vector2( 0, 0 )
constant_angular_velocity = 0.0
friction = 1.0
bounce = 0.0
script = ExtResource( 1 )
difficulty = 1

[node name="Sprite" type="Sprite" parent="."]

scale = Vector2( 0.5, 600 )
z = -100
texture = SubResource( 3 )
centered = false
_sections_unfolded = [ "Offset", "Transform", "Visibility" ]

[node name="CollisionShape2D" type="CollisionShape2D" parent="."]

position = Vector2( 512, 590 )
scale = Vector2( 0.593604, 0.999193 )
shape = SubResource( 1 )
_sections_unfolded = [ "Transform" ]

[node name="Sprite" type="Sprite" parent="CollisionShape2D"]

position = Vector2( -0.282013, 0.36175 )
scale = Vector2( 26.9813, 0.280884 )
texture = ExtResource( 2 )
__meta__ = {
"_edit_lock_": true
}


               extends KinematicBody2D

var velocity = Vector2(0,0)
export var jump_height = 300
export var gravity = 13.00
var acceleration = 10

onready var sprite = get_node("Sprite")
onready var shape = get_node("CollisionShape2D")
onready var anim = get_node("AnimationPlayer")

func _ready():
	get_parent().player = self
	velocity.x = 150
	pass

func _process(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_height
		#anim.play("jump")
	elif Input.is_action_just_pressed("eat"):
		pass#anim.play("eat")

func _physics_process(delta):
	
	velocity.x += acceleration *delta
	velocity.y += gravity
	
	velocity = move_and_slide(velocity,Vector2(0,-1))

        [gd_scene load_steps=4 format=2]

[ext_resource path="res://Player.gd" type="Script" id=1]
[ext_resource path="res://icon.png" type="Texture" id=2]

[sub_resource type="RectangleShape2D" id=1]

custom_solver_bias = 0.0
extents = Vector2( 30.1775, 32.3374 )

[node name="Player" type="KinematicBody2D"]

input_pickable = false
collision_layer = 1
collision_mask = 1
collision/safe_margin = 0.001
script = ExtResource( 1 )
_sections_unfolded = [ "collision" ]
jump_height = 300
gravity = 13.0

[node name="Sprite" type="Sprite" parent="."]

texture = ExtResource( 2 )

[node name="AnimationPlayer" type="AnimationPlayer" parent="."]

playback_process_mode = 1
playback_default_blend_time = 0.0
root_node = NodePath("../Sprite")
playback/active = true
playback/speed = 1.0
blend_times = [  ]
autoplay = ""

[node name="CollisionShape2D" type="CollisionShape2D" parent="."]

shape = SubResource( 1 )


              [gd_scene load_steps=3 format=2]

[ext_resource path="res://icon.png" type="Texture" id=1]

[sub_resource type="RectangleShape2D" id=1]

custom_solver_bias = 0.0
extents = Vector2( 12.7321, 12.8688 )

[node name="Box" type="StaticBody2D"]

input_pickable = false
collision_layer = 1
collision_mask = 1
constant_linear_velocity = Vector2( 0, 0 )
constant_angular_velocity = 0.0
friction = 1.0
bounce = 0.0

[node name="Sprite" type="Sprite" parent="."]

scale = Vector2( 0.4, 0.4 )
texture = ExtResource( 1 )
_sections_unfolded = [ "Transform" ]

[node name="CollisionShape2D" type="CollisionShape2D" parent="."]

shape = SubResource( 1 )


extends Node

onready var cam = get_node("Camera")
var score = 0
var highscore = 0
onready var l_score = get_node("Score")
onready var l_highscore = get_node("HighScore")
var scene_start = preload("res://Parts/Part.tscn")
var player
var time = 0

var parts_list = []
var parts = []

func spawn_tile():
	randomize()
	var rand_idx = rand_range(0,parts_list.size())
	var part = parts_list[rand_idx].instance()
	part.position = Vector2(parts[parts.size()-1].position.x + 1024,0)
	parts.append(part)
	add_child(part)
	print("spawned")

func _ready():
	set_process(true)
	var dir = Directory.new()
	if dir.open("res://Parts/") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
				parts_list.append(load("res://Parts/" + file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	pass
	
	var part = scene_start.instance()
	parts.append(part)
	add_child(part)

func _process(delta):
	time += delta
	score = int(time)
	if highscore < score: score = highscore 
	cam.position = Vector2(player.position.x-150,1)
	if player.global_position.x > parts[parts.size()-1].global_position.x - 512:
		spawn_tile()
	pass
  [gd_scene load_steps=3 format=2]

[ext_resource path="res://World.gd" type="Script" id=1]
[ext_resource path="res://Player.tscn" type="PackedScene" id=2]

[node name="World" type="Node2D"]

script = ExtResource( 1 )

[node name="Camera" type="Camera2D" parent="."]

anchor_mode = 0
rotating = false
current = true
zoom = Vector2( 1, 1 )
limit_left = -10000000
limit_top = -10000000
limit_right = 10000000
limit_bottom = 10000000
limit_smoothed = false
drag_margin_h_enabled = false
drag_margin_v_enabled = false
smoothing_enabled = false
smoothing_speed = 5.0
drag_margin_left = 0.0
drag_margin_top = 0.0
drag_margin_right = 0.0
drag_margin_bottom = 0.0
editor_draw_screen = true
editor_draw_limits = false
editor_draw_drag_margin = false
_sections_unfolded = [ "Drag Margin", "Limit", "Smoothing", "Transform" ]

[node name="Player" parent="." instance=ExtResource( 2 )]

position = Vector2( 70.9398, 499.46 )
_sections_unfolded = [ "Transform", "collision" ]

[node name="HighScore" type="Label" parent="."]

anchor_left = 0.0
anchor_top = 0.0
anchor_right = 0.0
anchor_bottom = 0.0
margin_right = 40.0
margin_bottom = 14.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 2
size_flags_horizontal = 1
size_flags_vertical = 4
text = "5"
percent_visible = 1.0
lines_skipped = 0
max_lines_visible = -1

[node name="Score" type="Label" parent="."]

anchor_left = 0.0
anchor_top = 0.0
anchor_right = 0.0
anchor_bottom = 0.0
margin_left = 137.0
margin_top = 3.0
margin_right = 177.0
margin_bottom = 17.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 2
size_flags_horizontal = 1
size_flags_vertical = 4
text = "10"
percent_visible = 1.0
lines_skipped = 0
max_lines_visible = -1

[node name="AudioStreamPlayer" type="AudioStreamPlayer" parent="."]

stream = null
volume_db = 0.0
autoplay = false
mix_target = 0
bus = "Master"


       [gd_resource type="Environment" load_steps=2 format=2]

[sub_resource type="ProceduralSky" id=1]

radiance_size = 4
sky_top_color = Color( 0.0470588, 0.454902, 0.976471, 1 )
sky_horizon_color = Color( 0.556863, 0.823529, 0.909804, 1 )
sky_curve = 0.25
sky_energy = 1.0
ground_bottom_color = Color( 0.101961, 0.145098, 0.188235, 1 )
ground_horizon_color = Color( 0.482353, 0.788235, 0.952941, 1 )
ground_curve = 0.01
ground_energy = 1.0
sun_color = Color( 1, 1, 1, 1 )
sun_latitude = 35.0
sun_longitude = 0.0
sun_angle_min = 1.0
sun_angle_max = 100.0
sun_curve = 0.05
sun_energy = 16.0
texture_size = 2

[resource]

background_mode = 2
background_sky = SubResource( 1 )
background_sky_custom_fov = 0.0
background_color = Color( 0, 0, 0, 1 )
background_energy = 1.0
background_canvas_max_layer = 0
ambient_light_color = Color( 0, 0, 0, 1 )
ambient_light_energy = 1.0
ambient_light_sky_contribution = 1.0
fog_enabled = false
fog_color = Color( 0.5, 0.6, 0.7, 1 )
fog_sun_color = Color( 1, 0.9, 0.7, 1 )
fog_sun_amount = 0.0
fog_depth_enabled = true
fog_depth_begin = 10.0
fog_depth_curve = 1.0
fog_transmit_enabled = false
fog_transmit_curve = 1.0
fog_height_enabled = false
fog_height_min = 0.0
fog_height_max = 100.0
fog_height_curve = 1.0
tonemap_mode = 0
tonemap_exposure = 1.0
tonemap_white = 1.0
auto_exposure_enabled = false
auto_exposure_scale = 0.4
auto_exposure_min_luma = 0.05
auto_exposure_max_luma = 8.0
auto_exposure_speed = 0.5
ss_reflections_enabled = false
ss_reflections_max_steps = 64
ss_reflections_fade_in = 0.15
ss_reflections_fade_out = 2.0
ss_reflections_depth_tolerance = 0.2
ss_reflections_roughness = true
ssao_enabled = false
ssao_radius = 1.0
ssao_intensity = 1.0
ssao_radius2 = 0.0
ssao_intensity2 = 1.0
ssao_bias = 0.01
ssao_light_affect = 0.0
ssao_color = Color( 0, 0, 0, 1 )
ssao_quality = 0
ssao_blur = 3
ssao_edge_sharpness = 4.0
dof_blur_far_enabled = false
dof_blur_far_distance = 10.0
dof_blur_far_transition = 5.0
dof_blur_far_amount = 0.1
dof_blur_far_quality = 1
dof_blur_near_enabled = false
dof_blur_near_distance = 2.0
dof_blur_near_transition = 1.0
dof_blur_near_amount = 0.1
dof_blur_near_quality = 1
glow_enabled = false
glow_levels/1 = false
glow_levels/2 = false
glow_levels/3 = true
glow_levels/4 = false
glow_levels/5 = true
glow_levels/6 = false
glow_levels/7 = false
glow_intensity = 0.8
glow_strength = 1.0
glow_bloom = 0.0
glow_blend_mode = 2
glow_hdr_threshold = 1.0
glow_hdr_scale = 2.0
glow_bicubic_upscale = false
adjustment_enabled = false
adjustment_brightness = 1.0
adjustment_contrast = 1.0
adjustment_saturation = 1.0

            GDST@   @           �  PNG �PNG

   IHDR   @   @   �iq�  tIDATx��{p�U�����#�t��y�@y@�	��D�8;#ಳ���S3���FJ�*�-�]fQ�qx�K��B��$�y����o�AB:�n���U����{�=�|����ۢ`�<<^? �V����.%!L��(�K���m�e5p,� ZD��y x�~��h�=#@u�48��n����@��1��Z�^��$�} j��V��R!�tK��/�"$��^�>��d�=R�����% �7�J�>!Im�	�Ԛ��x !$Tj:c�DB��������4BSd4h ��IH*���x �Tj��$ ����I:��@�J�3�U߅�R���N%-�B�A �V�u�it���J@�7������I � B��В`b��b�3�}��bg��b,	���U ����,̞2�IwR�3!����}���ưm~��1-�����P~�������49�Dϸ;�pD��L徱�!QV�ƻ{�8\�¸O�N�w��[���-�Ⱥ��<�`�0+w����,���u�$�n��ɳ�q�7�������E�ֲ�������w����͜1Cx����Kouk�O̠�dӑx�2��?P��3�ә~GcF����+hs��s\w:�&�&)���w����n���2�r()�'{���!vJ����Ql8T��/wk�����=U,~�I�f�MO��;\�N��Z��@�:[����]��Z������-G�¶�ym�"�h�24����7����[��{:��h������*�S�7}ċ�:���t��Վ�ew���#^�<�u2S�-�LM�y[�KfW=��^{�1���=�8ߝ6�݇������p����,|��&�MU���Ǝ�鋊������sOSR��ʷ6����L����0i�w ��}�xsC�rŨiO) &������i�p�C����/�S����>�MIQ9Y��e5�%Rn���%�ܒ��?�s����OL��?���ƤS�	�������?�(����)3�����x�Lv��"k�U��T#?�7��fݏ�d��i闁})��_���6���Q���geY����U'բg�ܙ��7���}��s�%���P��������n�݌�'S���y���d��SQ����\������j���4^j۾k�9	.[<I�a�S=��ht�t��[==��
+��BRiX�xn�r":`������+il��il���+W���)%�Ft���t�;�l��!�
����y��Y��Et@C��L��Iy���o3��Rȴih����?�MYEK��a3i��@b3iY2-���>�xwĺ
���o֡�^x0?�J$/<��FR��o�
�_@����K��vwg'SZ�wJ�VSZh���d^[�������F���e�3HO2�ZG��xr\�YV�&-�Ml=Vω����h)�Lb��t�N����xm��5rb5��ç{��u,`�k{M�Z�Z^�;�������M����[�n,�5�$���d# ��Iz������������2��xL�`oy�%�ydX��={�E1g�#�zx67ld��lF�%�m���'51�y�ȴD�O�fㆍ�zx6sf?¢��8{�,V#KJ�bQ�W��3��L����e�ϗQYy �������}{�:���Q����%�^PBqfR����۷�7^��3	RYy��?_���e��d����3��a�&�������ԣ|׮�d��<מ�$	$I�kO�)w��]�z.aMMM���#�`Xr�����+�O�N�\�����6��ËV~���WsG���v@c���]��撗��{)I3g��pU�)��UfΜ�$uW1/?���\�_v�%>�KZ��O�Q���rJKKIM�SXX����m���Tc�2w�j�m��|�/),,$5�N���X��+���C��$EO7�����iy����"�����h�6��m���~����\����ҫ�bԪQ�3;X��WT6��o��e�+������0hT��Z�Z"�v��"�+�Ŏ���	�
k�T�fOV�O@[�F��٠' �i<@PVX�eM�r��y#�����I�#@��%C�Q�N�ˏ�����]��OyC;m�9J���OK�f�b3i����L���'4������kvr�Çդ%+�Ș��nuZ=���z�Q�aaL���r���-����.��ǊI�.(����p�9��ΠY�ރ��i8Py�w�Vu{f���g�ΨtK���?�G�-��mrA
���|P����[x�J.?-����ߓM��!}X�Q;  ˨U=á�+J�9<gZѫ%�aBU�$H��[��owV��㟦�R���J�aW�j	�J����uԨ�`�e5QO�m�.����b���]^j���zW���U5�\W���j.�P�$��E���4W^jb���a5ii�� 5�P^]��9��;��Cq��\`p����AZ��+/�.�BWً�BH2j0i�u����+#�9s��O{���{��d��ߡ0�������'eq�e��ZL:5&��I����D���Nez���.��p�H6ki�hl���q���|A\� ��~v�i۾0�B��Ț#'�5+��Q�V���.����G���o��W��I�A��?�>�0꣱.|� /��DA���g �ƌ�����D^Y��O�%�epǾcd���x�L�*�W�����hQK��^���v^�`;���}�����`�%O�&�n�w;+8Zۿ��2&+�N�%�f⵵[X��O1�P����� ZC���ՔU�0�<Z2���8}.�6:���a6M��'����ʲ�ֲm�����Keԓ`84j5ߛu?���5�Ls���O5r�����mx�Oe�E��(L�P��Ĕ�vR���;Y���������]�`�ЅZ�b�]�̚2����U*�BeSU�\Էxhl������㗑C
mW��YT���Ua1h��Ǟ�'�j`� �'��AY��c����9RFP�q��ע�i(�Ϧ8?���3��"����h������q�������0�G"�;B���8x�O���L�Q��b#-�J�لѠC-IX-��rG�9�����t���BC� �=���VP�aVe�~3���o������@���SP�
� !y��m᪭
���� �o�;@���V�߹]�ZQ9���M���$��(�,	i�w{����ֿj'�� ^g�����U�̑ �j��ɠ�<(J!$��c��A�Og��n��PB�;��)!IV:P���V�g�>�*���d�Ƿ�`�-1u>�ۇ*=o n�O��Rp�9�j�P=B�>�������w���
��"��eY�Q�Ѩ��1>��g�    IEND�B`�   [remap]

importer="texture"
type="StreamTexture"
path="res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex"

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
      ECFG      application/config/name         xkcd_rex   application/run/main_scene         res://World.tscn   application/config/icon         res://icon.pngce   display/window/stretch/mode         2da    display/window/stretch/aspect         keep_height    gdnative/singletons          
   input/left             input/right          
   input/jump@              InputEventKey        resource_local_to_scene           resource_namep�          device               alt           shift            control           meta          command           pressed           scancode             unicode              echo          script         	   input/eat@              InputEventKey        resource_local_to_scene           resource_namep�          device               alt           shift            control           meta          command           pressed           scancode           unicode              echo          script         )   rendering/environment/default_environment          res://default_env.tres      GDPC