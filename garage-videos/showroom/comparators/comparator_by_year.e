note
	description: "compare two cars by year."
	author: "JSO"

class
	COMPARATOR_BY_YEAR[ID  -> COMPARABLE, MAKE -> attached ANY]
inherit
	KL_COMPARATOR[CAR[ID, MAKE]]

feature
	attached_less_than (car1, car2: CAR[ID, MAKE]): BOOLEAN
			-- Is `car1` less than `car2`?
		do
			Result := car1.year < car2.year
		end

end
