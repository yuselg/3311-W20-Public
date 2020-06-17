note
	description: "[
		Test examples with arrays and regular expressions.
		First test fails as Result is False by default.
		Write your own tests.
		Included libraries:
			base and extension
			Espec unit testing
			Mathmodels
			Gobo structures
			Gobo regular expressions
		]"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision 19.05$"

class
	TEST_EXAMPLE

inherit

	ES_TEST

create
	make

feature {NONE} -- Initialization

	make
			-- initialize tests
		do
			add_boolean_case (agent t0)
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)
			add_boolean_case (agent t5)

			-- violation tests

			add_violation_case_with_tag ("positive_miles", agent vt0)
		end

feature -- Boolean tests

	t0: BOOLEAN
		local
			car: CAR[STRING]
		do
			comment ("t0: test correct car construction")
			create car.make ("Porsche 911", 2020, 12)
			Result := car.odometer = 12
				and car.model ~ "Porsche 911"
				and car.year = 2020
		end

	t1: BOOLEAN
		local
			car: CAR[STRING]
		do
			comment ("t1: test odometer update")
			create car.make ("Porsche 911", 2020, 12)
			Result := car.odometer = 12
			check Result end
			car.update_odometer (8)
			assert_equal ("test odometer", car.odometer, 20)
		end

	t2: BOOLEAN
		local
			car: ELECTRIC_CAR[STRING]
		do
			comment ("t2: test electric car with battery upgrade")
			create car.make ("Tesla", 2018, 4380)
			Result := car.battery = 26
			check Result end
			car.upgrade_battery (40)
			Result := car.battery = 40
		end

	t3: BOOLEAN
		local
			garage: GARAGE[STRING]
			ford, chev: CAR[STRING]
			tesla: ELECTRIC_CAR[STRING]
			a: ARRAY[CAR[STRING]]
		do
			comment ("t3: create a garage of cars")
			create tesla.make ("Tesla", 2017, 4380)
			create ford.make ("Ford", 1977, 567906)
			create chev.make ("Tesla", 2020, 1003)
			create garage.make
			garage.add (tesla)
			garage.add (ford)
			garage.add (chev)
			a := garage.sorted_cars_by_year
			Result := garage.is_sorted (a)
		end

	t4: BOOLEAN
		local
			garage: GARAGE[STRING]
			ford, chev, civic: CAR[STRING]
			tesla: ELECTRIC_CAR[STRING]
			cars: SET[CAR[STRING]]
		do
			comment ("t4: filter via comprehension")
			create civic.make ("Civic", 1986, 677_999)
			create tesla.make ("Tesla", 2017, 4380)
			create ford.make ("Ford", 1977, 567906)
			create chev.make ("Chev", 2020, 1003)
			create garage.make
			garage.add (civic)
			garage.add (tesla)
			garage.add (ford)
			garage.add (chev)
			cars := garage.old_cars (1986)
			Result := cars.count = 2
				and cars.has (civic) and cars.has (ford)
		end

	t5: BOOLEAN
		local
			garage: GARAGE[STRING]
			ford, chev: CAR[STRING]
			tesla: ELECTRIC_CAR[STRING]
			a: ARRAY[CAR[STRING]]
		do
			comment ("t5: test binary search")
			create tesla.make ("Tesla", 2017, 4380)
			create ford.make ("Ford", 1977, 567906)
			create chev.make ("Tesla", 2020, 1003)
			create garage.make
			garage.add (tesla)
			garage.add (ford)
			garage.add (chev)

			-- sorted_cars: <<Ford 1977, Tesla 2017, Tesla 2020>>
			Result :=
						garage.search_car (2017) = 2
				and	garage.search_car (2019) = 0
		end


feature -- Violation tests

	vt0
		local
			car: CAR[STRING]
		do
			comment ("vt0: check correct precondition odometer construction")
			create car.make ("Porsche 911 ", 2020, -12)
		end
end
