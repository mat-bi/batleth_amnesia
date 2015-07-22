defmodule Mix.Tasks.Install do
  use Mix.Task
  use Database

  def run(_) do

    IO.inspect Amnesia.Schema.create
    #Amnesia.Schema.print
    IO.inspect Amnesia.start
	IO.puts "TRAN!"
    
    
    #IO.inspect Database.Record.create(disk: [node])

    #Database.Record.wait

    IO.inspect Database.create(disk: [node])

   

    Database.wait
	IO.puts "!NART"
    
    # Stop mnesia so it can flush everything and keep the data sane.
    #Amnesia.stop
  end
end
