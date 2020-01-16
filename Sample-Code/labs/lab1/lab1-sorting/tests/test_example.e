note
	description: "[
			Test the sorting of data cells (e.g., storing integers)
		]"
	author: "Jackie Wang"
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
		end

feature -- tests

	t0: BOOLEAN
		local
			c1, c2, c3: DATA_CELL[INTEGER]
			l_comparator: DATA_CELL_COMPARATOR[INTEGER]
			l_sorter: DS_ARRAY_QUICK_SORTER[DATA_CELL[INTEGER]]
			cells: ARRAY[DATA_CELL[INTEGER]]
		do
			comment ("t0: sorting data cells")
			create c1.make (77)
			create c2.make (17)
			create c3.make (23)
			create l_comparator
			create l_sorter.make (l_comparator)
			create cells.make_empty
			cells.force (c1, cells.count + 1)
			cells.force (c2, cells.count + 1)
			cells.force (c3, cells.count + 1)
			Result :=
				across
					1 |..| (cells.count - 1) is i
				all
					cells[i].item <= cells[i + 1].item
				end
			check not Result end

			l_sorter.sort (cells)
			Result :=
				across
					1 |..| (cells.count - 1) is i
				all
					cells[i].item <= cells[i + 1].item
				end
		end
end
