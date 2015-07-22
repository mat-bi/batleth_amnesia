defmodule Clock do
    
    @doc """
        Starts a new thread to count time for adding records. Takes one parameter - pid of the writer.
        If succeed, returns a tuple {:ok, pid}
        
         """
    def start(pid) do
        Task.start_link(fn() -> loop(pid) end)
    end

    defp loop(pid) do
        send pid, { self() }
        receive do
            {:error, problem} -> :not_implemented
            _ -> :timer.sleep(60000)
                 loop(pid)
        end
    end
    
end

