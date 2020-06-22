note
	description: "[
		Euclidean algorithm for Greatest Common Divisor.
		Use Design by Contract to check correctness and termination,
		via exhaustive run-time assertion checking.
		The loop is provided with a variant and loop invariant.
		The algorithm correctly establishes the postcondition. 
			gcd(m,n) is Euclid's efficient implementation
			gcd_spec(m,n) is a set theoretic specification of the
				greatest common divisor, which can be used in proofs.
				gcd_spec(m,n) can also be used as an oracle in testing.
		]"
	author: "JSO"

class
	EUCLID

feature -- euclid

	gcd(m, n: INTEGER): INTEGER
			-- return the gcd of `m` and `n`
		require
			non_zero:
				m >= 1 and n >= 1
		local
			x, y: INTEGER
		do
			from
				x := m
				y := n
			invariant -- gcd_spec(x,y) = max(divisors(x) ∩ divisors(y))
				gcd_spec(x,y) = gcd_spec(m,n)
				x >= 1 and y >= 1
			until
				x = y
			loop
				if x < y then
					y := y - x
				else -- y < x
					check y < x end
					x := x - y
				end
			variant x + y
			end
			check x = y and x = gcd_spec(m,n) end
			Result := x
		ensure
			gcd_spec: -- Result = max(divisors(m) ∩ divisors(n))
				Result = max(divisors(m) |/\| divisors(n))
		end

	divisors(n: INTEGER): SET[INTEGER]
			-- return set of divisors of `q`
		require n >= 1
		do
			create Result.make_empty
			across 1 |..| n is d loop
				if n \\ d = 0 then -- q is divisible by d
					Result.extend (d)
				end

			end
		ensure
			divisors_set: -- Result = {d ∈ 1..q | is_divisible (q, d)}
			Result ~ (range(1,n)| agent is_divisible (n, ?))
		end


feature {ES_TEST} -- helper queries

	gcd_spec(m, n:INTEGER): INTEGER
			-- specfication definition of gcd
		do
			 Result := max(divisors(m) |/\| divisors(n))
		ensure
			 Result = max(divisors(m) |/\| divisors(n))
		end


	is_divisible(i, j: INTEGER): BOOLEAN
			-- is `'` divisible by `q`
		do
			Result := i \\ j = 0
		ensure class
		end

	range(i,j:INTEGER): SET[INTEGER]
		require
			i <= j
		do
			create Result.make_empty
			across i |..| j is d loop
				Result.extend(d)
			end
		ensure class
		end

	max(s: SET[INTEGER]): INTEGER
		require not s.is_empty
		do
			s.choose_item
			Result := s.item
			across s is n loop
				if
					n >= Result
				then
					Result := n
				end
			end
		ensure class
			s.has (Result)
			across s is i all Result >= i  end
		end

end
