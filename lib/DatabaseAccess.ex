defmodule DatabaseAccess do
	use GenServer
	use Database

	@doc """
		Starts databaseaccess.
	"""
	def start do
		GenServer.start(__MODULE__, [], name: __MODULE__)
	end

	def get(at) do
		GenServer.call(__MODULE__, {:get, at})
	end
	
	def add(at) do
		GenServer.call(__MODULE__, {:add, at})
	end

	def handle_call({:get, :last_timestamp}, _, _) do
		case Wpis.getLast() do
                	nil -> {:reply, {:ok, 0}, []}
                        l when is_integer(l) -> {:reply, {:ok, l}, []}
                        _ -> {:reply, {:error, :db}, []}
		end
	end

	def handle_call({:add, nil}, _, _) do
		Wpis.parse_wpis(nil, nil, nil) |> Wpis.add
		{:reply, {:ok}, []}
	end

	def handle_call({:add, %{status: stat, pr: per}}, _, _) do
		case Wpis.parse_wpis(per, stat) |> Wpis.add do
			l when is_map(l) -> {:reply, {:ok}, []}
			nil -> {:reply, {:error, :db}, []}
		end
	end
end


