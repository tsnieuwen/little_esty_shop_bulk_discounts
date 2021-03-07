class Holiday
	attr_reader :date,
              :name

	def initialize(data)
		@date = data[:date].to_datetime
		@name = data[:name]
	end

end
