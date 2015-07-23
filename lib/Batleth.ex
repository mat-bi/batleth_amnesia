defmodule Batleth do
	use Application

	def start_link(_type, _args) do
		require Amnesia
		use Amnesia

		use Database
		Mix.Task.run(:install, [])
                Amnesia.start
		#{:ok, pid} = Clock.start_link
		{:ok, pid} = Supervisor.start_link

		#Mix.Task.run(:uninstall, [])
		{:ok, self()}
end
end


