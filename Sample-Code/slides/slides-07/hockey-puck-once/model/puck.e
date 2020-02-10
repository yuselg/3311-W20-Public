note
	description: "Summary description for {PUCK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class PUCK feature

	count: INTEGER

	strike
		do
			if count =0 then
				print("puck count: " + count.out +"%N")
			end
			count := count+1
			print("puck count: " + count.out + "; ")
		end

invariant
	count >= 0
end
