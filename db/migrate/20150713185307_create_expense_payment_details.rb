class CreateExpensePaymentDetails < ActiveRecord::Migration
  def change
    create_table :expense_payment_details do |t|
      t.float :treasury_debt
      t.float :treasury_credit
      t.float :bnp_debt
      t.float :bnp_credit
      t.float :abu_dhabi_debt
      t.float :abu_dhabi_credit
      t.float :operation_expense_debt
      t.float :operation_expense_credit
      t.float :sale_expense_debt
      t.float :sale_expense_credit
      t.float :general_managerial_debt
      t.float :general_managerial_credit
      t.float :creditor_debt
      t.float :creditor_credit
      t.float :purchases_debt
	  t.float :purchases_credit
	  t.float :das_debt
	  t.float :das_credit
	  t.float :clients_debt
	  t.float :clients_credit
	  t.float :sales_debt
	  t.float :sales_credit
	  t.float :sales_tax_debt
	  t.float :sales_tax_credit
	  t.float :aq_debt
	  t.float :aq_credit
	  t.float :e3temadat_mostanadeya_debt
	  t.float :e3temadat_mostanadeya_credit
	  t.float :outer_suppliers_debt
	  t.float :outer_suppliers_credit
	  t.float :osool_sabta_debt
	  t.float :osool_sabta_credit
	  t.float :m_moshtarayat_debt
	  t.float :m_moshtarayat_credit
	  t.float :bnp_euro_debt
	  t.float :bnp_euro_credit
	  t.float :fx_difference_debt
	  t.float :fx_difference_credit
	  t.float :aq_rasm_ta7seel_debt
	  t.float :aq_rasm_ta7seel_credit
	  t.float :income_tax_debt
	  t.float :income_tax_credit
	  t.float :rental_debt
	  t.float :rental_credit
	  t.float :contributor_creditor_debt
	  t.float :contributor_creditor_credit
	  t.float :bnp_dollar_debt
	  t.float :bnp_dollar_credit
	  t.float :abu_dhabi_dollar_debt
	  t.float :abu_dhabi_dollar_credit
	  t.float :supplier_debt
	  t.float :supplier_credit
	  t.float :abu_dhabi_euro_debt
	  t.float :abu_dhabi_euro_credit
	  t.float :other_debt
	  t.float :other_credit
      t.timestamps null: false
    end
  end
end
