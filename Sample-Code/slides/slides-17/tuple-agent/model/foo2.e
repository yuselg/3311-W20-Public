note
	description: "[
		Testing tuple for Void safety
		]"
class
	FOO2 [G -> attached ANY create default_create end]
create
    make
feature
    item: G -- item must be attached with a default_create

    make(tuple: TUPLE[detachable G])
        do
        	print(tuple.out); io.new_line -- this is ok

--          item := tuple[1]  -- VJAR error

			if attached {G} tuple[1] as l_item then
                item := l_item
                print(item.out) -- will not be Void
                io.new_line
            else
            	create item
            	-- without this we get VEVI error
            	-- for item
            end
        end
end



