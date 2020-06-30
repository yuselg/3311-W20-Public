note
	description: "Representation of a garage."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHOWROOM [ID -> COMPARABLE, MAKE -> attached ANY]

inherit
	ITERABLE[CAR[ID, MAKE]]

create
	make

feature {NONE} -- constructor

	make
			-- Initialize an empty garage.
		do
			create cars.make_empty
		ensure
			cars.count = 0
		end

feature -- Iterable

	new_cursor: ITERATION_CURSOR[CAR[ID, MAKE]]
			-- An iteration cursor pointing to a car.
		do
			Result := sorted_cars_by_year.new_cursor
		end

feature -- commands

	add (a_car: CAR [ID, MAKE])
			-- Park `a_car` in the garage.
		require
			not cars.has (a_car)
		do
			cars.extend (a_car)
			is_sorted := False
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

	sorted_cars_by_year: ARRAY [CAR[ID, MAKE]]
			-- sorted array of cars in the garage, by year
		local
			l_comparator: COMPARATOR_BY_YEAR [ID, MAKE]
			l_sorter: DS_ARRAY_QUICK_SORTER [CAR[ID, MAKE]]
			a: ARRAY [CAR[ID, MAKE]]
		do
			-- use built in sort routine to sort by car year
			Result := cars.as_array.deep_twin
			create l_comparator
			create l_sorter.make (l_comparator)
			l_sorter.sort (Result)
		ensure
			sorted: -- ∀i ∈ 1..n: Result[i].year ≤ Result[i+1].year, where n = Result.count-1
				is_sorted_by_year(Result)
		end




	old_cars (a_year: INTEGER): like cars
			-- return all cars older than `a_year`
		local
			a, b: ARRAY[CAR[ID, MAKE]]
			i: INTEGER
		do
			b := sorted_cars_by_year
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

	search_car (a_year: INTEGER): INTEGER
			-- return index to `sorted_cars_by_year` for car identified by `id`
			-- if it exists, otherwise zero
		require
			sorted: -- ∀i ∈ 1..n: sorted_cars_by_year[i].year ≤ sorted_cars_by_year[i+1].year, where n = sorted_cars_by_year.count-1
				is_sorted_by_year(sorted_cars_by_year)
		local
			p, q: INTEGER -- pivots
			mid: INTEGER  -- middle
			found: BOOLEAN
			an_array: like sorted_cars_by_year
		do
			an_array := sorted_cars_by_year
			from
				p := 1; q := an_array.count; Result := 0
			invariant
				target_not_found: not found implies
					Result = 0
				target_found: found implies
					p <= Result and Result <= q and an_array[Result].year = a_year
			until
				p > q or found
			loop
				mid := (p+q) // 2
				if an_array[mid].year > a_year then
					q := mid - 1
				elseif an_array[mid].year < a_year then
					p := mid + 1
				else -- p = q
					check an_array[mid].year ~ a_year end
					found := True
					Result := mid
				end
			variant
				(q - p + 1) - (if found then 1 else 0 end)
			end
		ensure  -- pure function
			target_not_found:
				not (across sorted_cars_by_year is car some car.year = a_year end) implies
					(Result = 0)
			target_found:
				across sorted_cars_by_year is car some car.year = a_year end implies
					(sorted_cars_by_year[Result].year = a_year)
		end



 feature -- helpers

	is_sorted_by_year(l_array: like sorted_cars_by_year): BOOLEAN
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

	by_year(a_car: CAR[ID, MAKE]; a_year: INTEGER): BOOLEAN
			-- Is the year of `a_car` less than `a_year`?
       do
			Result := a_car.year <= a_year
       end

feature -- general sorting

	is_sorted: BOOLEAN
	sorted: ARRAY [CAR[ID, MAKE]]
		require is_sorted
		attribute create Result.make_empty end

	sort(a_comparator: KL_COMPARATOR[CAR[ID, MAKE]])
				-- sort array `sorted` of cars by comparator type
			local
				l_sorted: SORTING[ID, MAKE]
			do
				create l_sorted.make
				sorted := l_sorted.sort (cars, a_comparator)
				is_sorted := True
			ensure
				sorted: -- ∀i ∈ 1..n: Result[i].year ≤ Result[i+1].year, where n = Result.count-1
					is_sorted
			end

invariant
	conistent_count: count = cars.count

end

