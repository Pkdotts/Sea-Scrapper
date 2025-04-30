extends Label

@export var message = ""
@export var digits = 2


func display_number(number):
	text = message + " " + get_number_with_zeros(number)

func get_number_with_zeros(number) -> String:
	number = str(number)
	var scorelen = len(number)
	var zeros = digits - scorelen
	if zeros > 0:
		for i in zeros:
			number = "0" + number
	return number
