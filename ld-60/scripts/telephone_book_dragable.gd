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

	return person_data

# Returns a boolean by examining the data being dragged to see if it's valid
# to drop here.
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return true


# Takes the data being dragged and processes it. In this case, we are
# assigning a new color to the target color picker button.
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	text = data
