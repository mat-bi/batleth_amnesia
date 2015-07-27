defmodule BatteryReader do
    use GenServer
    @doc """
        Starts a battery reader. Takes one argument - pid of the writer.
	If succeeded, returns a tuple {:ok, pid}
	"""	
	def start() do    
		GenServer.start(__MODULE__, [], name: __MODULE__)
	end


	defp parse_status(status) do
		case status do
			"Charging\n" -> 0
			"Discharging\n" -> 1
			"Unknown\n" -> 2
			"Full\n" -> 3
			"Not present\n" -> 4
			_ -> -1
		end
	end

	def read do
		GenServer.call(__MODULE__, {:read})
	end
	

	def handle_call({:read}, _, _) do
				case File.read("/sys/class/power_supply/BAT1/status") do
					{:error, :enoent} -> status = parse_status("Not present\n")
					{:ok, status} -> status = parse_status(status)
					_ -> :not_implemented
				end

				case File.read("/sys/class/power_supply/BAT1/capacity") do
					{:error, :enoent} -> percentage = 0
			 		{:ok, percentage} -> { percentage, _} = Integer.parse(percentage)
					_ -> :not_implemented
				end
				{:reply, { :ok, percentage, status}, []}
			
	end

end
