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
			add_boolean_case (agent t3a) -- sorted by Year
			add_boolean_case (agent t3b) -- sorted by ID
			add_boolean_case (agent t3c) -- sorted by Make
			add_boolean_case (agent t3d) -- change comparator kind dynamically for sorting
			add_boolean_case (agent t4)
			add_boolean_case (agent t5a) -- search by Year
			add_boolean_case (agent t5b) -- search by ID
			add_boolean_case (agent t5c) -- search by Make
			add_boolean_case (agent t5d) -- change comparator kind dynamically for searching
			add_boolean_case (agent t6)

			-- violation tests

			add_violation_case_with_tag ("positive_miles", agent vt0)
		end

feature -- Boolean tests

	t0: BOOLEAN
		local
			car: CAR[INTEGER, STRING]
		do
			comment ("t0: test correct car construction")
			create car.make_car (1, "Porsche 911", 2020, 12)
			Result := car.odometer = 12
				and car.make ~ "Porsche 911"
				and car.year = 2020
		end

	t1: BOOLEAN
		local
			car: CAR[INTEGER, STRING]
		do
			comment ("t1: test odometer update")
			create car.make_car (1, "Porsche 911", 2020, 12)
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
			create car.make_car (2, "Tesla", 2018, 4380)
			Result := car.battery = 26
			check Result end
			car.upgrade_battery (40)
			Result := car.battery = 40
		end

	t3a: BOOLEAN
		local
			showroom: SHOWROOM[INTEGER, STRING]
			ford, chev: CAR[INTEGER, STRING]
			tesla: ELECTRIC_CAR[INTEGER, STRING]
			a: ARRAY[CAR[INTEGER, STRING]]
		do
			comment ("t3a: create a showroom of cars (sorted based on comparison by Year)")
			create chev.make_car (1, "Tesla", 2020, 1003)
			create ford.make_car (2, "Ford", 1977, 567906)
			create tesla.make_car (3, "Tesla", 2017, 4380)
			create showroom.make_empty ({CHOICE[INTEGER, STRING]}.year)
			Result := showroom.comparator ~ "year"
			check Result end

			showroom.add (tesla)
			showroom.add (ford)
			showroom.add (chev)
			a := showroom.sorted_cars
			-- <<ford, tesla, chev>>
			Result :=
						showroom.is_sorted_by_year (a)
				and	a[1] ~ ford
				and 	a[2] ~ tesla
				and	a[3] ~ chev
		end

	t3b: BOOLEAN
		local
			showroom: SHOWROOM[INTEGER, STRING]
			ford, chev: CAR[INTEGER, STRING]
			tesla: ELECTRIC_CAR[INTEGER, STRING]
			a: ARRAY[CAR[INTEGER, STRING]]
		do
			comment ("t3b: create a showroom of cars (sorted based on comparison by ID)")
			create chev.make_car (1, "Tesla", 2020, 1003)
			create ford.make_car (2, "Ford", 1977, 567906)
			create tesla.make_car (3, "Tesla", 2017, 4380)
			create showroom.make_empty ({CHOICE[INTEGER, STRING]}.id)
			Result := showroom.comparator ~ "id"
			check Result end

			showroom.add (tesla)
			showroom.add (ford)
			showroom.add (chev)
			a := showroom.sorted_cars
			-- <<chev, ford, tesla>>
			Result :=
						showroom.is_sorted_by_id (a)
				and	a[1] ~ chev
				and 	a[2] ~ ford
				and	a[3] ~ tesla
		end

	t3c: BOOLEAN
		local
			showroom: SHOWROOM[INTEGER, STRING]
			ford, chev: CAR[INTEGER, STRING]
			tesla: ELECTRIC_CAR[INTEGER, STRING]
			a: ARRAY[CAR[INTEGER, STRING]]
		do
			comment ("t3c: create a showroom of cars (sorted based on comparison by Make)")
			create chev.make_car (1, "Tesla", 2020, 1003)
			create ford.make_car (2, "Ford", 1977, 567906)
			create tesla.make_car (3, "Tesla", 2017, 4380)
			create showroom.make_empty ({CHOICE[INTEGER, STRING]}.make)
			Result := showroom.comparator ~ "make"
			check Result end

			showroom.add (tesla)
			showroom.add (ford)
			showroom.add (chev)
			a := showroom.sorted_cars
			-- <<ford, chev, tesla>> (chev and tesla have the same make, so compare by year; see COMPARATOR_BY_MAKE)
			Result :=
						showroom.is_sorted_by_make (a)
				and	a[1] ~ ford
				and 	a[2] ~ chev
				and	a[3] ~ tesla
		end

	t3d: BOOLEAN
		local
			showroom: SHOWROOM[INTEGER, STRING]
			ford, chev: CAR[INTEGER, STRING]
			tesla: ELECTRIC_CAR[INTEGER, STRING]
			a: ARRAY[CAR[INTEGER, STRING]]
		do
			comment ("t3d: create a showroom of cars (and dynamically change the comparator kind for sorting)")
			create chev.make_car (1, "Tesla", 2020, 1003)
			create ford.make_car (2, "Ford", 1977, 567906)
			create tesla.make_car (3, "Tesla", 2017, 4380)
			create showroom.make_empty ({CHOICE[INTEGER, STRING]}.year)
			Result := showroom.comparator ~ "year"
			check Result end

			showroom.add (tesla)
			showroom.add (ford)
			showroom.add (chev)
			a := showroom.sorted_cars
			-- <<ford, tesla, chev>>
			Result :=
						showroom.is_sorted_by_year (a)
				and	a[1] ~ ford
				and 	a[2] ~ tesla
				and	a[3] ~ chev
			check Result end

			showroom.set_comparator ({CHOICE[INTEGER, STRING]}.id)
			Result := showroom.comparator ~ "id"
			check Result end

			a := showroom.sorted_cars
			-- <<chev, ford, tesla>>
			Result :=
						showroom.is_sorted_by_id (a)
				and	a[1] ~ chev
				and 	a[2] ~ ford
				and	a[3] ~ tesla
			check Result end

			showroom.set_comparator ({CHOICE[INTEGER, STRING]}.make)
			Result := showroom.comparator ~ "make"
			check Result end

			a := showroom.sorted_cars
			-- <<ford, chev, tesla>> (chev and tesla have the same make, so compare by year; see COMPARATOR_BY_MAKE)
			Result :=
						showroom.is_sorted_by_make (a)
				and	a[1] ~ ford
				and 	a[2] ~ chev
				and	a[3] ~ tesla
		end

	t4: BOOLEAN
		local
			showroom: SHOWROOM[INTEGER, STRING]
			ford, chev, civic: CAR[INTEGER, STRING]
			tesla: ELECTRIC_CAR[INTEGER, STRING]
			cars: SET[CAR[INTEGER, STRING]]
		do
			comment ("t4: filter via comprehension (with no use of comparator)")
			create civic.make_car (1, "Civic", 1986, 677_999)
			create tesla.make_car (2, "Tesla", 2017, 4380)
			create ford.make_car (3, "Ford", 1977, 567906)
			create chev.make_car (4, "Chev", 2020, 1003)
			create showroom.make_empty ({CHOICE[INTEGER, STRING]}.year)
			-- Note: searching and sorting of `showroom` will use the partial order defined in `c`
			showroom.add (civic)
			showroom.add (tesla)
			showroom.add (ford)
			showroom.add (chev)
			cars := showroom.old_cars (1986)
			Result := cars.count = 2
			-- Note: this membership check does not use `c`; instead, it uses {CAR}.is_equal
				and cars.has (civic) and cars.has (ford)
		end

	t5a: BOOLEAN
		local
			showroom: SHOWROOM[INTEGER, STRING]
			ford, chev, corolla: CAR[INTEGER, STRING]
			tesla: ELECTRIC_CAR[INTEGER, STRING]
		do
			comment ("t5a: test binary search on cars by year")
			create chev.make_car (1, "Tesla", 2020, 1003)
			create ford.make_car (2, "Ford", 1977, 567906)
			create tesla.make_car (3, "Tesla", 2017, 4380)
			create showroom.make_empty ({CHOICE[INTEGER, STRING]}.year)
			Result := showroom.comparator ~ "year"
			check Result end

			showroom.add (tesla)
			showroom.add (ford)
			showroom.add (chev)

			create corolla.make_car (4, "Corolla", 2019, 5000)

			-- sorted_cars (by year): <<ford, tesla, chev>>
			Result :=
						showroom.search_car (ford) = 1
				and	showroom.search_car (ford.deep_twin) = 1
				and	showroom.search_car (tesla) = 2
				and	showroom.search_car (tesla.deep_twin) = 2
				and 	showroom.search_car (chev) = 3
				and 	showroom.search_car (chev.deep_twin) = 3
				and	showroom.search_car (corolla) = 0
		end

	t5b: BOOLEAN
		local
			showroom: SHOWROOM[INTEGER, STRING]
			ford, chev, corolla: CAR[INTEGER, STRING]
			tesla: ELECTRIC_CAR[INTEGER, STRING]
		do
			comment ("t5b: test binary search on cars by ID")
			create chev.make_car (1, "Tesla", 2020, 1003)
			create ford.make_car (2, "Ford", 1977, 567906)
			create tesla.make_car (3, "Tesla", 2017, 4380)
			create showroom.make_empty ({CHOICE[INTEGER, STRING]}.id)
			Result := showroom.comparator ~ "id"
			check Result end

			showroom.add (tesla)
			showroom.add (ford)
			showroom.add (chev)

			create corolla.make_car (4, "Corolla", 2019, 5000)

			-- sorted_cars (by id): <<chev, ford, tesla>>
			Result :=
						showroom.search_car (chev) = 1
				and	showroom.search_car (chev.deep_twin) = 1
				and 	showroom.search_car (ford) = 2
				and 	showroom.search_car (ford.deep_twin) = 2
				and	showroom.search_car (tesla) = 3
				and	showroom.search_car (tesla.deep_twin) = 3
				and	showroom.search_car (corolla) = 0
		end

	t5c: BOOLEAN
		local
			showroom: SHOWROOM[INTEGER, STRING]
			ford, chev, corolla: CAR[INTEGER, STRING]
			tesla: ELECTRIC_CAR[INTEGER, STRING]
		do
			comment ("t5c: test binary search on cars by Make")
			create chev.make_car (1, "Tesla", 2020, 1003)
			create ford.make_car (2, "Ford", 1977, 567906)
			create tesla.make_car (3, "Tesla", 2017, 4380)
			create showroom.make_empty ({CHOICE[INTEGER, STRING]}.make)
			Result := showroom.comparator ~ "make"
			check Result end

			showroom.add (tesla)
			showroom.add (ford)
			showroom.add (chev)

			create corolla.make_car (4, "Corolla", 2019, 5000)

			-- sorted_cars (by make): <<ford, chev, tesla>>
			-- (chev and tesla have the same make, so compare by year; see COMPARATOR_BY_MAKE)
			Result :=
						showroom.search_car (ford) = 1
				and	showroom.search_car (ford.deep_twin) = 1
				and	showroom.search_car (chev) = 2
				and	showroom.search_car (chev.deep_twin) = 2
				and 	showroom.search_car (tesla) = 3
				and 	showroom.search_car (tesla.deep_twin) = 3
				and	showroom.search_car (corolla) = 0
		end

	t5d: BOOLEAN
		local
			showroom: SHOWROOM[INTEGER, STRING]
			ford, chev, corolla: CAR[INTEGER, STRING]
			tesla: ELECTRIC_CAR[INTEGER, STRING]
		do
			comment ("t5d: test binary search on cars (and dynamically change the comparator kind for searching)")
			create chev.make_car (1, "Tesla", 2020, 1003)
			create ford.make_car (2, "Ford", 1977, 567906)
			create tesla.make_car (3, "Tesla", 2017, 4380)
			create showroom.make_empty ({CHOICE[INTEGER, STRING]}.year)
			Result := showroom.comparator ~ "year"
			check Result end

			showroom.add (tesla)
			showroom.add (ford)
			showroom.add (chev)

			create corolla.make_car (4, "Corolla", 2019, 5000)

			-- sorted_cars (by year): <<ford, tesla, chev>>
			Result :=
						showroom.search_car (ford) = 1
				and	showroom.search_car (ford.deep_twin) = 1
				and	showroom.search_car (tesla) = 2
				and	showroom.search_car (tesla.deep_twin) = 2
				and 	showroom.search_car (chev) = 3
				and 	showroom.search_car (chev.deep_twin) = 3
				and	showroom.search_car (corolla) = 0
			check Result end

			showroom.set_comparator ({CHOICE[INTEGER, STRING]}.id)
			Result := showroom.comparator ~ "id"
			check Result end

			-- sorted_cars (by id): <<chev, ford, tesla>>
			Result :=
						showroom.search_car (chev) = 1
				and	showroom.search_car (chev.deep_twin) = 1
				and 	showroom.search_car (ford) = 2
				and 	showroom.search_car (ford.deep_twin) = 2
				and	showroom.search_car (tesla) = 3
				and	showroom.search_car (tesla.deep_twin) = 3
				and	showroom.search_car (corolla) = 0
			check Result end

			showroom.set_comparator ({CHOICE[INTEGER, STRING]}.make)
			Result := showroom.comparator ~ "make"
			check Result end

			-- sorted_cars (by make): <<ford, chev, tesla>>
			-- (chev and tesla have the same make, so compare by year; see COMPARATOR_BY_MAKE)
			Result :=
						showroom.search_car (ford) = 1
				and	showroom.search_car (ford.deep_twin) = 1
				and	showroom.search_car (chev) = 2
				and	showroom.search_car (chev.deep_twin) = 2
				and 	showroom.search_car (tesla) = 3
				and 	showroom.search_car (tesla.deep_twin) = 3
				and	showroom.search_car (corolla) = 0
		end

	t6: BOOLEAN
		local
			showroom: SHOWROOM[INTEGER, STRING]
			ford, chev: CAR[INTEGER, STRING]
			tesla: ELECTRIC_CAR[INTEGER, STRING]
			cars: ARRAY[CAR[INTEGER, STRING]]
		do
			comment ("t6: test iterable showroom")
			create tesla.make_car (1, "Tesla", 2017, 4380)
			create ford.make_car (2, "Ford", 1977, 567906)
			create chev.make_car (3, "Tesla", 2020, 1003)
			create showroom.make_empty ({CHOICE[INTEGER, STRING]}.id)
			showroom.add (tesla)
			showroom.add (ford)
			showroom.add (chev)

			create cars.make_empty
			across showroom is car loop
				cars.force (car, cars.count + 1)
			end
			Result :=
						cars[1] ~ tesla
				and	cars[2] ~ ford
				and	cars[3] ~ chev
		end

feature -- Violation tests

	vt0
		local
			car: CAR[INTEGER, STRING]
		do
			comment ("vt0: check correct precondition odometer construction")
			create car.make_car (1, "Porsche 911 ", 2020, -12)
		end
end
