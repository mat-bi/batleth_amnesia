defmodule Logging do
	use GenServer
	
	def start do
		GenServer.start(__MODULE__, [], name: __MODULE__)
	end

	def write(error) do
		GenServer.call(__MODULE__, {:write, error})
	end


	defp fwrite(error) do
	end
				
	def handle_call({:write, :no_db}, _, _) do
	end
end
