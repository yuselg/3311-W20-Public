note
	description: "[
		An expanded (=value) type. Description of an engine has horsepower,
		but not ncessarily the drive
		]"
	author: "JSO"
	date: "2020-02010"

expanded class
	ENGINE
inherit
	ANY
		redefine is_equal end
		-- uses default_create, no arguments
feature
	horsepower: INTEGER
	drive: detachable STRING

	put(a_hp:INTEGER; a_drive: STRING)
		do
			horsepower := a_hp
			drive := a_drive
		end

	is_equal(other: like Current): BOOLEAN
		do
			Result := horsepower = other.horsepower
				and drive ~ other.drive
		end
end
