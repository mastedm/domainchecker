class DomainsController < ApplicationController
	def index
		@domains = Domain.ordered_list
	end

	def new 
	end

	def create_bunch
		list = params[:list].split(/[\r\n]+/)
		comment = params[:comment]
		
		Rails.logger.debug list
		Rails.logger.debug comment
		
		if Domain.create_bunch(list, comment)
			redirect_to domains_path 	
			
		else 
			render "new"
			
		end

	end
end
