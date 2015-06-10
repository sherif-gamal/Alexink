class PermissionController < ApplicationController

	def production
		permission_id = params[:id]
		@permission = Permission.find(permission_id)
		@raw_materials = RawMaterial.all
		if request.xhr?
	      flash.discard(:notice)
	      render partial: 'production'
	    else
	      redirect_to "/dashboard##{request.path}"
	    end
	end

	def material
	end

	def purchase
	end

	def product
	end
end
