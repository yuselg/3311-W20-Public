note
	description: "Representation of a show room."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHOWROOM [ID -> COMPARABLE, MAKE -> COMPARABLE]

inherit
	ITERABLE[CAR[ID, MAKE]]

create
	make

feature {NONE} -- constructor

	make (a_comparator: KL_COMPARATOR[CAR[ID, MAKE]])
			-- Initialize an empty garage.
		do
			create cars.make_empty
			create util.make
			l_comparator := a_comparator
		ensure
			cars.count = 0
		end

feature -- Comparator for searching and sorting

	l_comparator: KL_COMPARATOR[CAR[ID, MAKE]]

feature -- Iterable

	new_cursor: ITERATION_CURSOR[CAR[ID, MAKE]]
			-- An iteration cursor pointing to a car.
		do
			Result := sorted_cars.new_cursor
		end

feature -- commands

	add (a_car: CAR [ID, MAKE])
			-- Park `a_car` in the garage.
		require
			not cars.has (a_car)
		do
			cars.extend (a_car)
		ensure
			cars ~ (old cars.deep_twin + a_car)
		end

feature -- queries

	count: INTEGER
			-- Number of cars in garage.
		do
			Result := cars.count
		end

	cars: SET [CAR[ID, MAKE]]
		-- Set of cars currently parked in the garage

	sorted_cars: ARRAY [CAR[ID, MAKE]]
			-- sorted array of cars in the garage, by year
		do
			Result := util.sort (cars.as_array, l_comparator)
		ensure
			is_sorted: -- ∀i ∈ 1..n: Result[i] < Result[i+1], where n = Result.count-1 and '<' is a partial order defined by `l_comparator`.
				across 1 |..| (Result.count - 1) is i
					all
						l_comparator.less_than (Result[i], Result[i + 1])
					end
		end

	old_cars (a_year: INTEGER): like cars
			-- return all cars older than `a_year`
		local
			a, b: ARRAY[CAR[ID, MAKE]]
			i: INTEGER
		do
			b := sorted_cars
			from
				i := 1
				create a.make_empty
			until
				b[i].year > a_year
			loop
				if b[i].year <= a_year then
					a.force (b[i], a.count + 1)
				end
				i := i + 1
			end
			create Result.make_from_array (a)
		ensure
			-- Result = {c ∈ cars | c.year ≤ a_year}
			Result ~ (cars | agent by_year(?, a_year))
		end

	search_car (a_car: CAR[ID, MAKE]): INTEGER
			-- Return index to `cars.as_array` for car identified by the partial order defined by`l_comparator`
			-- if it exists, otherwise zero.
		do
			Result := util.search_car (sorted_cars, a_car, l_comparator)
		ensure
			target_not_found:
				not (across sorted_cars is car some l_comparator.attached_order_equal (car, a_car) end) implies
					(Result = 0)
			target_found:
				(across sorted_cars is car some l_comparator.attached_order_equal (car, a_car) end) implies
					(l_comparator.attached_order_equal(sorted_cars[Result], a_car))
		end

feature {NONE} -- Utilities for implementation

	util: UTILITIES[ID, MAKE]

 feature {ES_TEST} -- Helpers for tests

	is_sorted_by_year(l_array: like sorted_cars): BOOLEAN
			-- Are cars in `l_array` sorted in non-descending order w.r.t. year?
		do
			Result := (across 1 |..| (l_array.count - 1) is i all
						l_array [i].year <= l_array [i + 1].year
					 end)
		ensure
			Result = (across 1 |..| (l_array.count - 1) is i all
						l_array [i].year <= l_array [i + 1].year
					 end)
		end

	is_sorted_by_id(l_array: like sorted_cars): BOOLEAN
			-- Are cars in `l_array` sorted in non-descending order w.r.t. id?
		do
			Result := (across 1 |..| (l_array.count - 1) is i all
						l_array [i].id <= l_array [i + 1].id
					 end)
		ensure
			Result = (across 1 |..| (l_array.count - 1) is i all
						l_array [i].id <= l_array [i + 1].id
					 end)
		end

	is_sorted_by_make(l_array: like sorted_cars): BOOLEAN
			-- Are cars in `l_array` sorted in non-descending order w.r.t. make?
		do
			Result := (across 1 |..| (l_array.count - 1) is i all
								if l_array [i].make ~ l_array [i + 1].make then
									l_array [i].id < l_array [i + 1].id
								else
									l_array [i].make < l_array [i + 1].make
								end
					 		end)
		ensure
			Result = (across 1 |..| (l_array.count - 1) is i all
								if l_array [i].make ~ l_array [i + 1].make then
									l_array [i].id <= l_array [i + 1].id
								else
									l_array [i].make < l_array [i + 1].make
								end
					 		end)
		end

feature {SHOWROOM} -- Helpers for contracts

	by_year(a_car: CAR[ID, MAKE]; a_year: INTEGER): BOOLEAN
			-- Is the year of `a_car` less than `a_year`?
       do
			Result := a_car.year <= a_year
       end

invariant

	conistent_count:
		count = cars.count

end

