extends TextureRect

var current_menu = null
var current_button = null

func _ready():
	current_button = $Hoardm
	current_menu = $Build_men
	register_buttons()

func register_buttons():
	var buttons = get_tree().get_nodes_in_group("sub_menu")
	for button in buttons:
		button.pressed.connect(_on_button_pressed.bind(button.name))

func _on_button_pressed(_name):
	match _name:
		"Hoardm":
			change_screen($Build_men, $Hoardm)
		"Upgrades":
			change_screen($Upgrade_men, $Upgrades)
		"Trophies":
			change_screen($Trophy_men, $Trophies)
		"restarto":
			change_screen($restart_men, $restarto)

func change_screen(new_menu, pbutton):
	if current_menu:
		current_button.disabled = false
		current_menu.visible = false
	current_button = pbutton
	current_menu = new_menu
	if new_menu:
		current_button.disabled = true
		current_menu.visible = true
