class PermissionController < ApplicationController

	def production
		permission_id = params[:id]
		@permission = ProductionPermission.find(permission_id)
		@production  = Production.find(@permission.transaction_id)
		@raw_material = RawMaterial.find(@production.raw_material_id)
		if request.xhr?
	      flash.discard(:notice)
	      render partial: 'production'
	    else
	      redirect_to "/dashboard##{request.path}"
	    end
	end

	def expense
		permission_id = params[:id]
		@permission = ReleaseMoneyPermission.find(permission_id)
		@expense  = Expense.find(@permission.transaction_id)
		if request.xhr?
	      flash.discard(:notice)
	      render partial: 'expense'
	    else
	      redirect_to "/dashboard##{request.path}"
	    end
	end

	def material_stock
		permission_id = params[:id]
		@permission = AddMaterialPermission.find(permission_id)
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
		@permission = ReleaseMoneyPermission.find(permission_id)
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
		@permission1 = AddMaterialPermission.find(permission1_id)
		@permission2 = ReleaseMoneyPermission.find(permission2_id)
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
		@permission = ReleaseProductPermission.find(permission_id)
		@purchase = Purchase.find(@permission.transaction_id)
		@products = Product.find(@purchase.product_ids)
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
		@permission = ReleaseProductPermission.find(permission_id)
		@invoice = Invoice.find(invoice_id)
		@purchase = Purchase.find(@permission.transaction_id)
		@products = Product.find(@purchase.product_ids)
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
		@permission = AddProductPermission.find(permission_id)
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
		@material_permissions = AddMaterialPermission.all
		@product_permissions = AddProductPermission.all
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
		@production_permissions = ProductionPermission.all
		@purchase_permissions = ReleaseProductPermission.all
		@products = Product.all
		@purchases = Purchase.all
		if request.xhr?
	      flash.discard(:notice)
	      render partial: 'subtractions'
	    else
	      redirect_to "/dashboard##{request.path}"
	    end
	end

	def treasury
		@permissions = ReleaseMoneyPermission.all
		@expenses = Expense.all
		@materials = Material.all
		if request.xhr?
	      flash.discard(:notice)
	      render partial: 'treasury'
	    else
	      redirect_to "/dashboard##{request.path}"
	    end
	end
end
