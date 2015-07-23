defmodule Batleth do
	use Application

	def start(_type, _args) do
		require Amnesia
		use Amnesia

		use Database
		Mix.Task.run(:install, [])
                Amnesia.start
		{:ok, pid} = Clock.start
		#Amnesia.transaction do
		#	%Wpis{timestamp: 55555, status: 2, pr: 87} |> Wpis.write!
                #        %Wpis{timestamp: 4344, status: 2, pr: 34} |> Wpis.write!
                #        %Wpis{timestamp: 43444, status: 2, pr: 3444} |> Wpis.write!
		#end

		#Amnesia.transaction do
		#	r = Wpis.where timestamp > 2
                #        IO.inspect r
		#	r |> Amnesia.Selection.values |> Enum.each &IO.inspect(&1)
		#end

		#Mix.Task.run(:uninstall, [])
		{:ok, self()}
end
end


