note
	description: "Summary description for {WEATHER_DATA_SUBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEATHER_DATA_SUBJECT
inherit
	WEATHER_DATA
		redefine
			make
		end
	SUBJECT
		rename
			make as subject_make
		end
create
	make

feature{NONE}
	make
		do
			subject_make
			Precursor
		end
feature

	measurements_changed
			-- called from weather station after set
		do
			notify
		ensure then
			observers_updated: observers.for_all (agent update_action_completed(?))
		end

end
