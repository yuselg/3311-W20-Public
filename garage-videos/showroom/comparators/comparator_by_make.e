note
	description: "compare two cars by make."
	author: "Jackie Wang"

class
	COMPARATOR_BY_MAKE[ID  -> COMPARABLE, MAKE -> COMPARABLE]

inherit
	KL_COMPARATOR[CAR[ID, MAKE]]

feature
	attached_less_than (car1, car2: CAR[ID, MAKE]): BOOLEAN
			-- Is `car1` less than `car2`?
		do
			if car1.make ~ car2.make then
				Result := car1.id < car2.id
			else
				Result := car1.make < car2.make
			end
		end

end
