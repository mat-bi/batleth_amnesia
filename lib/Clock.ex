defmodule Clock do
    

    @doc """
        Starts a new thread to count time for adding records. Takes one parameter - pid of the writer.
        If succeeded, returns a tuple {:ok, pid}
        """
	def start_link() do
                
        	Task.start_link(fn() ->
                loop(true) end)
	end




    	defp loop(bo \\false) do
		case DatabaseAccess.get(:last_timestamp) do
			{:ok, last_timestamp} ->
				time_dif = Time.timestamp - last_timestamp

				if time_dif >= 60 do
					if time_dif > 60 and bo do
						{:ok} = DatabaseAccess.add(nil)
					end

					{:ok, percentage, status} = BatteryReader.read

					DatabaseAccess.add(%{status: status, pr: percentage})
					:timer.sleep(60000)	
                		        loop()
				else
					:timer.sleep(60000 - time_dif*1000)
					loop()
				end
		end
	end
    
end

