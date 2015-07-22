defmodule BatteryReader do

    @doc """
        Starts a battery reader. Takes one argument - pid of the writer.
	If succeeded. returns a tuple {:ok, pid}
	"""	
	def start(pid) do    
		Task.start_link(fn() -> loop(pid) end)
	end



	defp parse_status(status) do
		case status do
			"Charging\n" -> 0
			"Discharging\n" -> 1
			"Unknown\n" -> 2
			"Not present\n" -> 3
			_ -> -1
		end
	end



	defp loop(pid) do
		receive do
			{:read, caller} -> 
			#if caller == pid do
				case File.read("/sys/class/power_supply/BAT1/status") do
					{:error, reason} -> :not_implemented
					{:ok, status} -> status = parse_status(status)
					_ -> :not_implemented
				end

				case File.read("/sys/class/power_supply/BAT1/capacity") do
					{:error, reason} -> :not_implemented
			 		{:ok, percentage} -> { percentage, _} = Integer.parse(percentage)
					_ -> :not_implemented
				end
				send caller, { :ok, percentage, status, self() }
			#else
			#	:not_implemented
			#end
			_ -> :not_implemented		
		end
             loop(pid)
	end

end
