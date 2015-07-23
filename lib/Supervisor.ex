defmodule Batleth.Supervisor do
	use Supervisor

	@Batleth_Clock Clock
	@Batleth_Batteryreader BatteryReader
	@Batleth_Databaseaccess DatabaseAccess
#
	def init(:ok) do
		children = [
			worker(Clock, [[name: @Batleth_Clock]]),
			worker(BatteryReader, [[name: @Batleth_Batteryreader]])]

	end
end
