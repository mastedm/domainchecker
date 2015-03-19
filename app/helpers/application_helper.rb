module ApplicationHelper
	def date_format datetime
		datetime.strftime("%F")
	rescue
		"-"	
	end

	def highlight_css_class expiration_date
		if (expiration_date.to_date - Time.now.to_date) < 30
			"red_highlight"
		end
	rescue
		""	
	end
end
