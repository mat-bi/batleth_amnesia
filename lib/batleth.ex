use Amnesia
use Database


defmodule Batleth do
	use Application

	def start(_type, _args) do
		Mix.Task.run(:install, [])
		IO.puts "Witaj swiecie"
Amnesia.transaction do
	IO.puts "Tran1"
	r = %Wpis{timestamp: 55555, status: 2, pr: 87} 
	IO.inspect(Wpis.write(r))
end
Amnesia.transaction do
	r = Wpis.where timestamp == 55555
	IO.inspect r
end

IO.puts "Hello World"
	Mix.Task.run(:uninstall, [])
{:ok, self()}
end
end


