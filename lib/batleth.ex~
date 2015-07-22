


defmodule Batleth do
	use Application

	def start(_type, _args) do
		require Amnesia
		use Amnesia

		use Database
		Mix.Task.run(:install, [])
                Amnesia.start
		Amnesia.transaction do
			IO.puts "Tran1"
			%Wpis{timestamp: 55555, status: 2, pr: 87} |> Wpis.write!
                        %Wpis{timestamp: 4344, status: 2, pr: 34} |> Wpis.write!
                        %Wpis{timestamp: 43444, status: 2, pr: 3444} |> Wpis.write!
		end

		Amnesia.transaction do
			r = Wpis.where timestamp > 2, select: [status, timestamp, pr]
                        IO.inspect r
			r |> Amnesia.Selection.values |> Enum.each &IO.inspect(&1)
		end

		Mix.Task.run(:uninstall, [])
		{:ok, self()}
end
end


