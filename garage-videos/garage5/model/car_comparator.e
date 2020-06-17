note
	description: "compare two cars by year."
	author: "JSO"

class
	CAR_COMPARATOR[G -> attached ANY]
inherit
	KL_COMPARATOR[CAR[G]]

feature
	attached_less_than (car1, car2: CAR[G]): BOOLEAN
			-- Is `car1` less than `car2`?
		do
			Result := car1.year < car2.year
		end

end
