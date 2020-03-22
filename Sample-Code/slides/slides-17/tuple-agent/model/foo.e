note
	description: "[
		Testing tuple for Void safety
		]"
class
	FOO[ G -> attached ANY]

create
    make
feature
    item1: G
    item2: G

    make(tuple: TUPLE[g:G])
        do
        	print(tuple.out); io.new_line

            -- first way
            item1 := tuple.g  -- first way
            print(item1.out)  -- requires G -> attached ANY
            io.new_line

            --second way, tuple[1] is tuple.item(1)
            if attached {G} tuple[1] as item then
                item2 := item
                print(item2.out) -- might be Void
           	else
           		item2 := item1
--           		 so that item2 does not generate a VEVI error
            end
        end
end


