defmodule Batleth do
	use Application

	def start(_,_) do
		require Amnesia
		use Amnesia
		use Database

                Amnesia.start
		Database.wait

		import Supervisor.Spec
		children = [
			worker(Logging, [[], [name: :logger]]),
			worker(DatabaseAccess, [[], [name: :base]]),
			worker(BatteryReader, [[], [name: :battery]])
			]
		{:ok, pid_s} = Supervisor.start_link(children, strategy: :one_for_one)
		{:ok, pid} = Clock.start_link
		

		{:ok, self()}
end
end


