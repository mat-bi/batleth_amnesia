defmodule Clock do
    

    @doc """
        Starts a new thread to count time for adding records. Takes one parameter - pid of the writer.
        If succeed, returns a tuple {:ok, pid}
        """
	def start(pid, pid_r) do
        	Task.start_link(fn() -> loop(pid, pid_r) end)
	end




    	defp loop(pid, pid_r) do
        	send pid, {self()}
		send pid, {:get, :last_timestamp}

		receive do
			{:ok, last_timestamp} -> 
				{ms, s, _} = :os.timestamp
				time_dif = ms * 1_000_000 + s - last_timestamp

				if time_dif >= 60 do
					send pid_r, {:read, self()}
					receive do
						{:ok, percentage, status, caller} ->
							send pid, {:add, self()}
							receive do
								{:ok, 
							:timer.sleep(60000)}
							
						_ -> :not_implemented

				else
					:timer.sleep(60000 - time_dif*1000)
					loop(pid, pid_r)
				end

			{:error} -> 

        	receive do
			
			{:error, problem} -> :not_implemented
			_ -> :timer.sleep(60000)
			loop(pid)
		end
    	end
    
end

