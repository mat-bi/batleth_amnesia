defmodule DatabaseAccess do

	@doc """
		Starts a databaseaccess. Takes two parameters - pids of the reader and the clock.
		If succeeded, returns a tuple {:ok, pid}  
	"""
	def start(pid_r, pid_c) do
		Task.start_link(fn() -> loop(pid_r, pid_c) end)
	end

	defp loop(pid_r, pid_c) do
		receive do
			{:add, caller} -> 
				if caller == pid_c do
                                        
					send pid_c, {:status, self()}
					receive do
						{:ok, percentage, status, caller} -> :not_implemented
						_ -> :not_implemented
					end
				end
			_ -> :not_implemented
		end
	end
end 
