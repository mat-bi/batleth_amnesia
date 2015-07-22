defmodule Clock do
    

    @doc """
        Starts a new thread to count time for adding records. Takes one parameter - pid of the writer.
        If succeed, returns a tuple {:ok, pid}
        """
	def start() do
                
        	Task.start_link(fn() ->
                {:ok, pid_d} = DatabaseAccess.start(self())
                {:ok, pid_r} = BatteryReader.start(self())
                loop(pid_d, pid_r) end)
	end




    	defp loop(pid_d, pid_r) do
		send pid_d, {:get, :last_timestamp, self()}

		receive do
			{:ok, last_timestamp} -> 
                                IO.puts "#{last_timestamp}"
				{ms, s, _} = :os.timestamp
				time_dif = ms * 1_000_000 + s - last_timestamp

				if time_dif >= 60 do
					send pid_r, {:read, self()}
                                        IO.puts "przed receive"
					receive do
						{:ok, percentage, status, caller} ->
							send pid_d, {:add, %{status: status, pr: percentage}, self()}
							receive do
								{:ok} -> :timer.sleep(60000)
								{:error, :db} -> :not_implemented
							end

						_ -> :not_implemented
					end
                                        IO.puts "po receive"
                                        loop(pid_d, pid_r)
				else
					:timer.sleep(60000 - time_dif*1000)
					loop(pid_d, pid_r)
				end

			{:error, :db} -> :not_implemented
		end

        	receive do
			
			{:error, problem} -> :not_implemented
			_ -> :timer.sleep(60000)
			loop(pid_d, pid_r)
		end
    	end
    
end

