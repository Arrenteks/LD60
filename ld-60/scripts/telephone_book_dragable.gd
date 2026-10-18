extends Button
class_name TelephoneBookDragable

var person_data: PersonData

# Returns the data to pass from an object when you click and drag away from
# this object. Also calls `set_drag_preview()` to show the mouse dragging
# something so the user knows that the operation is working.
func _get_drag_data(_at_position: Vector2) -> PersonData:
	# Use another Button as drag preview.
	var temp_button := Button.new()
	temp_button.text = person_data._get_text()
	temp_button.size = Vector2(117.0, 31.0)
	

	# Allows us to center the color picker on the mouse.
	var preview := Control.new()
	preview.add_child(temp_button)
	temp_button.position = -0.5 * temp_button.size

	# Sets what the user will see they are dragging.
	set_drag_preview(preview)

	# Return color as drag data.
	return person_data
