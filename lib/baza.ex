require Amnesia
use Amnesia

defdatabase Base do
    deftable Record, [:timestamp, :status, :pr], type: :ordered_set, index: [:timestamp] do
        @type t :: %Wpis{timestamp: non_neg_integer, status: String.t, pr: non_neg_integer}
        
        @doc """
            Returns a list of records from timestamp to timestamp.
            """
        def get(tmp2, tmp3) do
            :not_implemented
        end

        @doc """
            Adds and saves a record in the database
            """
        def add(self) do
            :not_implemented
        end
    end
end
