note
	description: "Summary description for {TAX_PAYER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SWISS_US_TAX_PAYER
inherit
	US_TAX_PAYER
		rename
			id as us_id
		select
			us_id
		end
	SWISS_TAX_PAYER
		rename
			id as swiss_id
		end

create
	make
end
