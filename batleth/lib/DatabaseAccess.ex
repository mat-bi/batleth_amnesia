defmodule DatabaseAccess do
	use GenServer
	use Database

	@supervision_name :base

	@doc """
		Starts databaseaccess.
	"""
	def start_link( state, opts) do
		GenServer.start(__MODULE__,  [], [name: @supervision_name])
	end

	def get(at) do
		GenServer.call(@supervision_name, {:get, at})
	end
	
	def add(at) do
		GenServer.call(@supervision_name, {:add, at})
	end
	
	defp no_db do
		Logging.write(:no_db)
	end

	def handle_call({:get, :last_timestamp}, _, _) do
		case Wpis.getLast() do
                	nil -> {:reply, {:ok, 0}, []}
                        l when is_integer(l) -> {:reply, {:ok, l}, []}
                        _ ->    no_db
				{:reply, {:error, :db}, []}
		end
	end

	def handle_call({:add, nil}, _, _) do
		if is_map(Wpis.parse_wpis(nil, nil, nil) |> Wpis.add) do
			{:reply, {:ok}, []}
		else
			no_db
			{:reply, {:error, :db}, []}
		end
	end

	def handle_call({:add, %{status: stat, pr: per}}, _, _) do
		case Wpis.parse_wpis(per, stat) |> Wpis.add do
			l when is_map(l) -> {:reply, {:ok}, []}
			nil -> 
				no_db
				{:reply, {:error, :db}, []}
		end
	end
end


