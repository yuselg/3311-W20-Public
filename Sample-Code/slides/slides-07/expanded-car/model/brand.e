note
	description: "A reference type."
	author: "JSO"
	date: "2020-02010"

class BRAND create
	make
feature {NONE} -- constructor
	make(a_brand: STRING)
			-- create a brand
		do
			brand := a_brand
		end
feature
	brand: STRING
end
