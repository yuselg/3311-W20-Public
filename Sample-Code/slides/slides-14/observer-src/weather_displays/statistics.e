note
	description: "Summary description for {STATISTICS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STATISTICS

inherit
	OBSERVER
create
	make

feature {NONE} --creation
	make(wd: WEATHER_DATA_SUBJECT)
		do
			weather_data := wd
			min_temp := 15
			max_temp := 5
			wd.attach (Current)
		end

feature



	weather_data: WEATHER_DATA_SUBJECT
	temp: REAL
	max_temp: REAL
	min_temp: REAL
	temp_sum: REAL

	num_readings: INTEGER


	up_to_date_with_subject: BOOLEAN
			-- is this observer up to date with its subject
		do
			if  temp = weather_data.temperature then
				Result := true
			end
		end


	update
			-- update the observer's view of `s'
		do
			temp := weather_data.temperature
			num_readings := num_readings + 1
			temp_sum := temp_sum + temp
			if temp > max_temp then
				max_temp := temp
			elseif  temp < min_temp then
				min_temp := temp
			end
			display
		end



	display
		do
			print("Avg/Max/Min temperature = ")
			print(temp_sum / num_readings)
			print("/")
			print(max_temp)
			print("/")
			print(min_temp)
			print("%N")
		end

end
