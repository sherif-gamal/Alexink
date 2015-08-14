class RevisionController < ApplicationController

	def index
		if params['year'].present?
			@_year = 	params['year'].to_i
		else
			@_year = Time.now.year
		end

		@revision = calculate_revision @_year

		super
	end

	def update
		@revision = Revision.find(revision_params[:id])
		@revision.update(revision_params)
		redirect_to "/revision/#{@revision.year}"
	end

	private

		def revision_params
			params.require(:revision).permit!
		end

		def calculate_revision(year)
			details = ExpensePaymentDetail.joins('inner join expenses on expenses.id = expense_payment_details.id where expenses.date_added like "' + year.to_s + '%"' )
			details = details + MaterialPaymentDetail.joins('inner join materials on materials.id = material_payment_details.id where materials.date_added like "' + year.to_s + '%"' )
			details = details + PurchasePaymentDetail.joins('inner join purchases on purchases.id = purchase_payment_details.id where purchases.date_added like "' + year.to_s + '%"' )
			treasury_debt, treasury_credit, bnp_debt, bnp_credit, abu_dhabi_debt, abu_dhabi_credit,
			 operation_expense_debt, operation_expense_credit, sale_expense_debt, sale_expense_credit, general_managerial_debt, general_managerial_credit, creditor_debt, creditor_credit, purchases_debt, purchases_credit, das_debt, das_credit, clients_debt, clients_credit, sales_debt, sales_credit, sales_tax_debt, sales_tax_credit, aq_debt, aq_credit, e3temadat_mostanadeya_debt, e3temadat_mostanadeya_credit, outer_suppliers_debt, outer_suppliers_credit, osool_sabta_debt, osool_sabta_credit, m_moshtarayat_debt, m_moshtarayat_credit, bnp_euro_debt, bnp_euro_credit, fx_difference_debt, fx_difference_credit, aq_rasm_ta7seel_debt, aq_rasm_ta7seel_credit, income_tax_debt, income_tax_credit, rental_debt, rental_credit, contributor_creditor_debt, contributor_creditor_credit, bnp_dollar_debt, bnp_dollar_credit, abu_dhabi_dollar_debt, abu_dhabi_dollar_credit, supplier_debt, supplier_credit, abu_dhabi_euro_debt, abu_dhabi_euro_credit, other_debt, other_credit = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

			details.each do |d|
				treasury_debt = treasury_debt + (d.treasury_debt || 0)
				treasury_credit = treasury_credit + (d.treasury_credit || 0)
				bnp_debt = bnp_debt + (d.bnp_debt || 0)
				bnp_credit = bnp_credit + (d.bnp_credit || 0)
				abu_dhabi_debt = abu_dhabi_debt + (d.abu_dhabi_debt || 0)
				abu_dhabi_credit = abu_dhabi_credit + (d.abu_dhabi_credit || 0)
				operation_expense_debt = operation_expense_debt + (d.operation_expense_debt || 0)
				operation_expense_credit = operation_expense_credit + (d.operation_expense_credit || 0)				
				sale_expense_debt = sale_expense_debt + (d.sale_expense_debt || 0)
				sale_expense_credit = sale_expense_credit + (d.sale_expense_credit || 0)
				general_managerial_debt = general_managerial_debt + (d.general_managerial_debt || 0)
				general_managerial_credit = general_managerial_credit + (d.general_managerial_credit || 0)
				creditor_debt = creditor_debt + (d.creditor_debt || 0)
				creditor_credit = creditor_credit + (d.creditor_credit || 0)
				purchases_debt = purchases_debt + (d.purchases_debt || 0)
				purchases_credit = purchases_credit + (d.purchases_credit || 0)
				das_debt = das_debt + (d.das_debt || 0)
				das_credit = das_credit + (d.das_credit || 0)
				clients_debt = clients_debt + (d.clients_debt || 0)
				clients_credit = clients_credit + (d.clients_credit || 0)
				sales_debt = sales_debt + (d.sales_debt || 0)
				sales_credit = sales_credit + (d.sales_credit || 0)
				sales_tax_debt = sales_tax_debt + (d.sales_tax_debt || 0)
				sales_tax_credit = sales_tax_credit + (d.sales_tax_credit || 0)
				aq_debt = aq_debt + (d.aq_debt || 0)
				aq_credit = aq_credit + (d.aq_credit || 0)
				e3temadat_mostanadeya_debt = e3temadat_mostanadeya_debt + (d.e3temadat_mostanadeya_debt || 0)
				e3temadat_mostanadeya_credit = e3temadat_mostanadeya_credit + (d.e3temadat_mostanadeya_credit || 0)
				outer_suppliers_debt = outer_suppliers_debt + (d.outer_suppliers_debt || 0)
				outer_suppliers_credit = outer_suppliers_credit + (d.outer_suppliers_credit || 0)
				osool_sabta_debt = osool_sabta_debt + (d.osool_sabta_debt || 0)
				osool_sabta_credit = osool_sabta_credit + (d.osool_sabta_credit || 0)
				m_moshtarayat_debt = m_moshtarayat_debt + (d.m_moshtarayat_debt || 0)
				m_moshtarayat_credit = m_moshtarayat_credit + (d.m_moshtarayat_credit || 0)
				bnp_euro_debt = bnp_euro_debt + (d.bnp_euro_debt || 0)
				bnp_euro_credit = bnp_euro_credit + (d.bnp_euro_credit || 0)
				fx_difference_debt = fx_difference_debt + (d.fx_difference_debt || 0)
				fx_difference_credit = fx_difference_credit + (d.fx_difference_credit || 0)
				aq_rasm_ta7seel_debt = aq_rasm_ta7seel_debt + (d.aq_rasm_ta7seel_debt || 0)
				aq_rasm_ta7seel_credit = aq_rasm_ta7seel_credit + (d.aq_rasm_ta7seel_credit || 0)
				income_tax_debt = income_tax_debt + (d.income_tax_debt || 0)
				income_tax_credit = income_tax_credit + (d.income_tax_credit || 0)
				rental_debt = rental_debt + (d.rental_debt || 0)
				rental_credit = rental_credit + (d.rental_credit || 0)
				contributor_creditor_debt = contributor_creditor_debt + (d.contributor_creditor_debt || 0)
				contributor_creditor_credit = contributor_creditor_credit + (d.contributor_creditor_credit || 0)
				bnp_dollar_debt = bnp_dollar_debt + (d.bnp_dollar_debt || 0)
				bnp_dollar_credit = bnp_dollar_credit + (d.bnp_dollar_credit || 0)
				abu_dhabi_dollar_debt = abu_dhabi_dollar_debt + (d.abu_dhabi_dollar_debt || 0)
				abu_dhabi_dollar_credit = abu_dhabi_dollar_credit + (d.abu_dhabi_dollar_credit || 0)
				supplier_debt = supplier_debt + (d.supplier_debt || 0)
				supplier_credit = supplier_credit + (d.supplier_credit || 0)
				abu_dhabi_euro_debt = abu_dhabi_euro_debt + (d.abu_dhabi_euro_debt || 0)
				abu_dhabi_euro_credit = abu_dhabi_euro_credit + (d.abu_dhabi_euro_credit || 0)
				other_debt = other_debt + (d.other_debt || 0)
				other_credit = other_credit + (d.other_credit || 0)
			end
			data = {year: year, treasury_debt: treasury_debt, treasury_credit: treasury_credit,
      			bnp_debt: bnp_debt, bnp_credit: bnp_credit,
      			abu_dhabi_debt: abu_dhabi_debt, abu_dhabi_credit: abu_dhabi_credit, 
      			operation_expense_debt: operation_expense_debt, operation_expense_credit: operation_expense_credit,
      			sale_expense_debt: sale_expense_debt, sale_expense_credit: sale_expense_credit,
      			general_managerial_debt: general_managerial_debt, general_managerial_credit: general_managerial_credit,
      			creditor_debt: creditor_debt, creditor_credit: creditor_credit,
      			purchases_debt: purchases_debt, purchases_credit: purchases_credit,
      			das_debt: das_debt, das_credit: das_credit, clients_debt: clients_debt, clients_credit: clients_credit,
      			sales_debt: sales_debt, sales_credit: sales_credit, sales_tax_debt: sales_tax_debt, sales_tax_credit: sales_tax_credit,
      			aq_debt: aq_debt, aq_credit: aq_credit, e3temadat_mostanadeya_debt: e3temadat_mostanadeya_debt, e3temadat_mostanadeya_credit: e3temadat_mostanadeya_credit,
      			outer_suppliers_debt: outer_suppliers_debt, outer_suppliers_credit: outer_suppliers_credit,
      			osool_sabta_debt: osool_sabta_debt, osool_sabta_credit: osool_sabta_credit,
      			m_moshtarayat_debt: m_moshtarayat_debt, m_moshtarayat_credit: m_moshtarayat_credit,
      			bnp_euro_debt: bnp_euro_debt, bnp_euro_credit: bnp_euro_credit, fx_difference_debt: fx_difference_debt, fx_difference_credit: fx_difference_credit,
      			aq_rasm_ta7seel_debt: aq_rasm_ta7seel_debt, aq_rasm_ta7seel_credit: aq_rasm_ta7seel_credit,
      			income_tax_debt: income_tax_debt, income_tax_credit: income_tax_credit,
      			rental_debt: rental_debt, rental_credit: rental_credit, contributor_creditor_debt: contributor_creditor_debt, contributor_creditor_credit: contributor_creditor_credit,
      			bnp_dollar_debt: bnp_dollar_debt, bnp_dollar_credit: bnp_dollar_credit,
      			abu_dhabi_dollar_debt: abu_dhabi_dollar_debt, abu_dhabi_dollar_credit: abu_dhabi_dollar_credit,
      			supplier_debt: supplier_debt, supplier_credit: supplier_credit, abu_dhabi_euro_debt: abu_dhabi_euro_debt, abu_dhabi_euro_credit: abu_dhabi_euro_credit,
      			other_debt: other_debt, other_credit: other_credit}

			revision = Revision.where(year: @_year).first

			if (revision)
      			revision.update(data)
      		else
      			Revision.create(data)
      		end
      		return revision
		end
end
