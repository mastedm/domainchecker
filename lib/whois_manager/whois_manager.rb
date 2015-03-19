class WhoisManager
	LOGGER = Logger.new("#{Rails.root}/log/whois_manager.log")

	def initialize
		@client = Whois::Client.new
	end

	def lookup(domain_name)
		@client.lookup(domain_name)
	end

	def self.whois(domain_name)
		Whois.whois(domain_name)
	end

	def self.expiration_date(domain_name)
		r = WhoisManager.whois(domain_name)

		if r && r.registered?
			r.properties[:expires_on]
		else
			raise "domain: #{domain_name} is unregistered"
		end

	rescue Exception => e	
		LOGGER.error "domain: #{domain_name}"
		LOGGER.error "error: #{e.message}"
    LOGGER.error e.backtrace.join("\r\n")
    nil
	end

	def self.parse_expiration_dates
		CriticalSection.by "parse_expiration_dates" do
			Domain.to_check_list.each do |e|
				exp_date = WhoisManager.expiration_date(e.name)

				if exp_date
					e.expiration_date = exp_date
					e.next_check_date = e.generate_next_check_date
					e.save
				end

				sleep 10
			end
		end
	end
end