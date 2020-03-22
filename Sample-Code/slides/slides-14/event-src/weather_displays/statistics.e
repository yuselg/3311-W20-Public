note
	description: "Summary description for {STATISTICS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STATISTICS
create
	make

feature {NONE} --creation
	make
		do
			min_temp := 15
			max_temp := 5

			broker.weather_event.subscribe (agent update)
		end

feature

	broker: BROKER



	temp: REAL
	max_temp: REAL
	min_temp: REAL
	temp_sum: REAL

	num_readings: INTEGER



	update(t,p,h:REAL)
			-- update the observer's view of `s'
		do
			temp := t
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
