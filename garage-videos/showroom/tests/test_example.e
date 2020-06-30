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
			add_boolean_case (agent t6)
			add_boolean_case (agent t7)

			-- violation tests

			add_violation_case_with_tag ("positive_miles", agent vt0)
		end

feature -- Boolean tests
	showroom:  SHOWROOM[INTEGER, STRING]
		attribute create Result.make end

	t0: BOOLEAN
		local
			car: CAR[INTEGER, STRING]
		do
			comment ("t0: test correct car construction")
			create car.add_car (1, "Porsche 911", 2020, 12)
			Result := car.odometer = 12
				and car.make ~ "Porsche 911"
				and car.year = 2020
		end

	t1: BOOLEAN
		local
			car: CAR[INTEGER, STRING]
		do
			comment ("t1: test odometer update")
			create car.add_car (1, "Porsche 911", 2020, 12)
			Result := car.odometer = 12
			check Result end
			car.update_odometer (8)
			assert_equal ("test odometer", car.odometer, 20)
		end

	t2: BOOLEAN
		local
			car: ELECTRIC_CAR[INTEGER, STRING]
		do
			comment ("t2: test electric car with battery upgrade")
			create car.add_car (2, "Tesla", 2018, 4380)
			Result := car.battery = 26
			check Result end
			car.upgrade_battery (40)
			Result := car.battery = 40
		end

	t3: BOOLEAN
		local
			garage: SHOWROOM[INTEGER, STRING]
			ford, chev: CAR[INTEGER, STRING]
			tesla: ELECTRIC_CAR[INTEGER, STRING]
			a: ARRAY[CAR[INTEGER, STRING]]
		do
			comment ("t3: create a garage of cars")
			create tesla.add_car (1, "Tesla", 2017, 4380)
			create ford.add_car (2, "Ford", 1977, 567906)
			create chev.add_car (3, "Tesla", 2020, 1003)
			create garage.make
			garage.add (tesla)
			garage.add (ford)
			garage.add (chev)
			a := garage.sorted_cars_by_year
			Result := garage.is_sorted_by_year (a)
		end

	t4: BOOLEAN
		local
			garage: SHOWROOM[INTEGER, STRING]
			ford, chev, civic: CAR[INTEGER, STRING]
			tesla: ELECTRIC_CAR[INTEGER, STRING]
			cars: SET[CAR[INTEGER, STRING]]
		do
			comment ("t4: filter via comprehension")
			create civic.add_car (1, "Civic", 1986, 677_999)
			create tesla.add_car (2, "Tesla", 2017, 4380)
			create ford.add_car (3, "Ford", 1977, 567906)
			create chev.add_car (4, "Chev", 2020, 1003)
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
			garage: SHOWROOM[INTEGER, STRING]
			ford, chev: CAR[INTEGER, STRING]
			tesla: ELECTRIC_CAR[INTEGER, STRING]
--			a: ARRAY[CAR[INTEGER, STRING]]
		do
			comment ("t5: test binary search")
			create tesla.add_car (1, "Tesla", 2017, 4380)
			create ford.add_car (2, "Ford", 1977, 567906)
			create chev.add_car (3, "Tesla", 2020, 1003)
			create garage.make
			garage.add (tesla)
			garage.add (ford)
			garage.add (chev)

			-- sorted_cars: <<Ford 1977, Tesla 2017, Tesla 2020>>
			Result :=
						garage.search_car (2017) = 2
				and	garage.search_car (2019) = 0
		end

	t6: BOOLEAN
		local
			garage: SHOWROOM[INTEGER, STRING]
			ford, chev: CAR[INTEGER, STRING]
			tesla: ELECTRIC_CAR[INTEGER, STRING]
			cars: ARRAY[CAR[INTEGER, STRING]]
		do
			comment ("t6: test iterable garage")
			create tesla.add_car (1, "Tesla", 2017, 4380)
			create ford.add_car (2, "Ford", 1977, 567906)
			create chev.add_car (3, "Tesla", 2020, 1003)
			create garage.make
			garage.add (tesla)
			garage.add (ford)
			garage.add (chev)

			create cars.make_empty
			across garage is car loop
				cars.force (car, cars.count + 1)
			end
			Result :=
						cars[1] ~ ford
				and	cars[2] ~ tesla
				and	cars[3] ~ chev
		end

	t7: BOOLEAN
		local
			garage: SHOWROOM[INTEGER, STRING]
			ford, chev, datsun: CAR[INTEGER, STRING]
			tesla: ELECTRIC_CAR[INTEGER, STRING]
			cars: ARRAY[CAR[INTEGER, STRING]]
			a: ARRAY[CAR[INTEGER, STRING]]
			c: COMPARATOR_BY_ID[INTEGER, STRING]
		do
			comment ("t7: test iterable garage")
			create tesla.add_car (1, "Tesla", 2017, 4380)
			create datsun.add_car (6, "Datsun", 1973, 200_987)
			create ford.add_car (2, "Ford", 1977, 567906)
			create chev.add_car (3, "Tesla", 2020, 1003)
			create garage.make
			garage.add (tesla)
			garage.add (datsun)
			garage.add (ford)
			garage.add (chev)
			create c
			create cars.make_empty
			garage.sort (c)
			a := garage.sorted
--			Result := garage.is_sorted_by_year (a)
		end

feature -- Violation tests

	vt0
		local
			car: CAR[INTEGER, STRING]
		do
			comment ("vt0: check correct precondition odometer construction")
			create car.add_car (1, "Porsche 911 ", 2020, -12)
		end
end
