defmodule Logging do
	use GenServer


	def start_link(state, opts) do
		GenServer.start(__MODULE__, state, opts)
	end

	def write(error) do
		GenServer.call(:logger, {:write, error})
	end
	defp reply() do
		{:reply, {:ok}, []}
	end

	defp fwrite(error) do
		File.write("/var/log/batleth/#{Time.month}.log", Time.date_and_time <> " " <> error<>"\n", [:append])
	end
				
	def handle_call({:write, :no_db}, _, _) do
		fwrite("Database not present")
		reply
	end

	def handle_call({:write, :bad_cmd}, _, _) do
		fwrite("Bad command")
		reply
	end
end
