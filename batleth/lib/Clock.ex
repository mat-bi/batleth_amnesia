defmodule Clock do
    use GenServer

    @supervision_name :clock

    @doc """
        Starts a new thread to count time for adding records.
        If succeeded, returns a tuple {:ok, pid}
        """
	def start_link(_, _) do
        	GenServer.start(__MODULE__, [], [name: @supervision_name])
	end

	def read do
		GenServer.call(@supervision_name, {:read})
	end

	def handle_call({:read}, _, _) do
		case DatabaseAccess.get(:last_timestamp) do
			{:ok, last_timestamp} ->
				time_dif = Time.timestamp-last_timestamp
				if time_dif < 60 do
					{:reply, {:wait, time_dif}, []}
				else
					{:reply, {:ok, time_dif}, []}
				end
			{:error, :db} -> {:reply, {:error, :db}, []}
		end
	end
end

