note
	description: "compare two cars by id."
	author: "JSO"

class
	COMPARATOR_BY_ID[ID -> COMPARABLE, MAKE -> attached ANY]
inherit
	KL_COMPARATOR[CAR[ID, MAKE]]

feature
	attached_less_than (car1, car2: CAR[ID, MAKE]): BOOLEAN
			-- Is `car1` less than `car2`?
		do
			Result := car1.id < car2.id
		end

end

