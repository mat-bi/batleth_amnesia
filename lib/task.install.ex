defmodule Mix.Tasks.Install do
  use Mix.Task
  use Database

  def run(_) do

    IO.inspect Amnesia.Schema.create
    IO.inspect Amnesia.start    
    
   
    IO.inspect Database.create(disk: [node])

   

    IO.inspect Database.wait
	    
    # Stop mnesia so it can flush everything and keep the data sane.
    #IO.inspect Amnesia.stop
  end
end
