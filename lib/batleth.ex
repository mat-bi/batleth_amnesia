require Amnesia
use Amnesia
use Database


defmodule Batleth do
	use Application

	def start(_type, _args) do
		Mix.Task.run(:install, [])
                Amnesia.start
		IO.puts "Witaj swiecie"
Amnesia.transaction do
	IO.puts "Tran1"
	r = %Wpis{timestamp: 55555, status: 2, pr: 87} 
        Wpis.write r
	IO.inspect(r)
end
Amnesia.start
Amnesia.transaction do
        IO.puts "Tran2"
	r = Wpis.where timestamp == 55555
	IO.inspect r
end

IO.puts "Hello World"
	Mix.Task.run(:uninstall, [])
{:ok, self()}
end
end


