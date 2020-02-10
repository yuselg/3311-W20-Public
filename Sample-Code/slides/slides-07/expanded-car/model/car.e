note
	description: "A car contains an engine and has a brand"
	author: "JSO"
	date: "2020-02010"

class
	CAR
create
	make
feature {NONE} -- Initialization	
	make(a_year:INTEGER; a_brand: BRAND; a_engine: ENGINE)
		do
			year   := a_year
			brand  := a_brand
			engine := a_engine
		end
feature
	year: INTEGER
	engine: ENGINE  	-- expanded
	brand:  BRAND 	-- reference
invariant
	year >= 0
end
