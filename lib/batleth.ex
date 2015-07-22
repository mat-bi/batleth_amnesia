


defmodule Batleth do
	use Application

	def start(_type, _args) do
		require Amnesia
		use Amnesia

		use Database
		Mix.Task.run(:install, [])
                Amnesia.start
		IO.puts "Witaj swiecie"
		Amnesia.transaction do
			IO.puts "Tran1"
			r = %Wpis{timestamp: 55555, status: 2, pr: 87} |> Wpis.write
			IO.puts r.timestamp
		end

		Amnesia.transaction do
		        IO.puts "Tran2"
			r = Wpis.where timestamp == 55555, select: status
			IO.inspect r
			IO.puts "Żegnaj świecie"
			r |> Amnesia.Selection.values |> Enum.each &IO.puts(&1.status)
		end



		IO.puts "Hello World"
		#Mix.Task.run(:uninstall, [])
		{:ok, self()}
end
end


