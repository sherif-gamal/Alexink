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

	def material_stock
		permission_id = params[:id]
		@permission = Permission.find(permission_id)
		@material = Material.find(@permission.transaction_id)
		@raw_material = RawMaterial.find(@material.raw_material_id)
		@supplier = Supplier.find(@material.supplier_id)
		if request.xhr?
	      flash.discard(:notice)
	      render partial: 'material_stock'
	    else
	      redirect_to "/dashboard##{request.path}"
	    end
	end

	def material_expense
		permission_id = params[:id]
		@permission = Permission.find(permission_id)
		@material = Material.find(@permission.transaction_id)
		@raw_material = RawMaterial.find(@material.raw_material_id)
		@supplier = Supplier.find(@material.supplier_id)
		if request.xhr?
	      flash.discard(:notice)
	      render partial: 'material_expense'
	    else
	      redirect_to "/dashboard##{request.path}"
	    end
	end

	def material
		permission1_id = params[:id1]
		permission2_id = params[:id2]
		@permission1 = Permission.find(permission1_id)
		@permission2 = Permission.find(permission2_id)
		@material = Material.find(@permission1.transaction_id)
		@raw_material = RawMaterial.find(@material.raw_material_id)
		@supplier = Supplier.find(@material.supplier_id)
		if request.xhr?
	      flash.discard(:notice)
	      render partial: 'material'
	    else
	      redirect_to "/dashboard##{request.path}"
	    end
	end

	def purchase
		permission_id = params[:id]
		@permission = Permission.find(permission_id)
		@purchase = Purchase.find(@permission.transaction_id)
		@product = Product.find(@purchase.product_id)
		@client = Client.find(@purchase.client_id)
		
		if request.xhr?
	      flash.discard(:notice)
	      render partial: 'purchase'
	    else
	      redirect_to "/dashboard##{request.path}"
	    end
	end

	def purchase_with_invoice
		permission_id = params[:id1]
		invoice_id = params[:id2]
		@permission = Permission.find(permission_id)
		@invoice = Invoice.find(invoice_id)
		@purchase = Purchase.find(@permission.transaction_id)
		@product = Product.find(@purchase.product_id)
		@client = Client.find(@purchase.client_id)
		
		if request.xhr?
	      flash.discard(:notice)
	      render partial: 'purchase_with_invoice'
	    else
	      redirect_to "/dashboard##{request.path}"
	    end
	end

	def product
		permission_id = params[:id]
		@permission = Permission.find(permission_id)
		@product = Product.find(@permission.transaction_id)
		if request.xhr?
	      flash.discard(:notice)
	      render partial: 'product'
	    else
	      redirect_to "/dashboard##{request.path}"
	    end
	end

	def additions
		@raw_materials = RawMaterial.all
		@materials = Material.all
		@material_permissions = Permission.where("transaction_type = 1")
		@product_permissions = Permission.where("transaction_type = 3")
		@products = Product.all
		if request.xhr?
	      flash.discard(:notice)
	      render partial: 'additions'
	    else
	      redirect_to "/dashboard##{request.path}"
	    end
	end

	def subtractions
		@raw_materials = RawMaterial.all
		@productions = Production.all
		@production_permissions = Permission.where("transaction_type = 2")
		@purchase_permissions = Permission.where("transaction_type = 4")
		@products = Product.all
		@purchases = Purchase.all
		if request.xhr?
	      flash.discard(:notice)
	      render partial: 'subtractions'
	    else
	      redirect_to "/dashboard##{request.path}"
	    end
	end
end
