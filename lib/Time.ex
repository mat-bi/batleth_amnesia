defmodule Time do

	def timestamp(format \\ :sec) do
		{ms, s, mss} = :os.timestamp
		case format do
			:sec ->
				ms * 1_000_000 + s
			:msec ->
				ms*1_000_000_000 +1000*s+mss
			_ -> nil
		end
	end
	
	defp local_time do
		:calendar.local_time()
	end

	def month do
		{{_, m, _}, {_,_,_}} = local_time
		m
	end

	def day do
		{{_, _, d}, {_, _, _}} = local_time
		d
	end

	def year do
		{{y, _, _}, {_, _, _}} = local_time
		y
	end

	def hour do
		{{_, _, _}, {h, _, _}} = local_time
		h
	end

	def minute do
		{{_, _, _}, {_, m, _}} = local_time
		m
	end

	def second do
		{{_, _, _}, {_, _, s}} = local_time
		s
	end
end
