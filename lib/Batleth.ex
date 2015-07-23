defmodule Batleth do
	use Application

	def start(_type, _args) do
		require Amnesia
		use Amnesia

		use Database
		Mix.Task.run(:install, [])
                Amnesia.start
		#{:ok, pid} = Clock.start_link
		{:ok, pid} = Batleth.Supervisor.init(:ok)

		#Mix.Task.run(:uninstall, [])
		{:ok, self()}
end
end


