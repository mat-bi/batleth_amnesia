defmodule Batleth do
	use Application

	def start(_,_) do
		require Amnesia
		use Amnesia
		use Database

		import Supervisor.Spec
		children = [
			worker(Logging, [[], [name: :logger]]),
			worker(DatabaseAccess, [[], [name: :base]]),
			worker(BatteryReader, [[], [name: :battery]]),
			worker(Clock, [[], [name: :clock]])
			]
		Supervisor.start_link(children, strategy: :one_for_one)
		loop(true)
		#{:ok, pid} = Task.start_link(fn -> loop(true) end)

		{:ok, self()}
	end
	
	
	def loop(bo \\ false) do
			Amnesia.start
			Database.wait
			case Clock.read do
				{at, time_dif} when is_atom(at) and is_integer(time_dif) ->
					case at do
						:ok ->
							t = Time.timestamp
							if time_dif > 60 and bo do
								{:ok} = DatabaseAccess.add(nil)
							end
	
							{:ok, percentage, status} = BatteryReader.read
	
							DatabaseAccess.add(%{status: status, pr: percentage})
							:timer.sleep(60000+(Time.timestamp-t)*1000)	
						:wait -> 
							:timer.sleep(60000 - time_dif*1000)
						_ -> Logging.write(:bad_cmd)
							
					end
				_ -> Logging.write(:bad_cmd)
					:timer.sleep(2000)
			end
			Amnesia.stop
			loop()
	end
end


