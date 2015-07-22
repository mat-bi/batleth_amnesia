defmodule DatabaseAccess do
        use Database
	@doc """
		Starts a databaseaccess. Takes two parameters - pids of the reader and the clock.
		If succeeded, returns a tuple {:ok, pid}  
	"""
	def start(pid_c) do
		Task.start_link(fn() -> loop(pid_c) end)
	end
      
	defp loop(pid_c) do
		receive do
			{:get, :last_timestamp, caller} -> 
                            unless caller == pid_c do
                                send caller, {:error}
                            end
                            case Wpis.getLast() do
                                nil -> send caller, {:ok, 0}
                                l -> send caller, {:ok, l }
                                _ -> send caller, { :error, :db }
                            end

                        {:add, wpis, caller} ->
                            unless caller == pid_c do
                                send caller, {:error}
                            end
                            Wpis.parse_wpis(wpis.pr, wpis.status) |> Wpis.add
                            send caller, {:ok}
                            
			_ -> :not_implemented
		end
                loop(pid_c)
	end
end 
