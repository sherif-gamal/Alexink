class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.float :treasury_debt, default: 0
      t.float :treasury_credit, default: 0
      t.float :bnp_debt, default: 0
      t.float :bnp_credit, default: 0
      t.float :abu_dhabi_debt, default: 0
      t.float :abu_dhabi_credit, default: 0
      t.float :operation_expense_debt, default: 0
      t.float :operation_expense_credit, default: 0
      t.float :sale_expense_debt, default: 0
      t.float :sale_expense_credit, default: 0
      t.float :general_managerial_debt, default: 0
      t.float :general_managerial_credit, default: 0
      t.float :creditor_debt, default: 0
      t.float :creditor_credit, default: 0
      t.float :purchases_debt, default: 0
	  t.float :purchases_credit, default: 0
	  t.float :das_debt, default: 0
	  t.float :das_credit, default: 0
	  t.float :clients_debt, default: 0
	  t.float :clients_credit, default: 0
	  t.float :sales_debt, default: 0
	  t.float :sales_credit, default: 0
	  t.float :sales_tax_debt, default: 0
	  t.float :sales_tax_credit, default: 0
	  t.float :aq_debt, default: 0
	  t.float :aq_credit, default: 0
	  t.float :e3temadat_mostanadeya_debt, default: 0
	  t.float :e3temadat_mostanadeya_credit, default: 0
	  t.float :outer_suppliers_debt, default: 0
	  t.float :outer_suppliers_credit, default: 0
	  t.float :osool_sabta_debt, default: 0
	  t.float :osool_sabta_credit, default: 0
	  t.float :m_moshtarayat_debt, default: 0
	  t.float :m_moshtarayat_credit, default: 0
	  t.float :bnp_euro_debt, default: 0
	  t.float :bnp_euro_credit, default: 0
	  t.float :fx_difference_debt, default: 0
	  t.float :fx_difference_credit, default: 0
	  t.float :aq_rasm_ta7seel_debt, default: 0
	  t.float :aq_rasm_ta7seel_credit, default: 0
	  t.float :income_tax_debt, default: 0
	  t.float :income_tax_credit, default: 0
	  t.float :rental_debt, default: 0
	  t.float :rental_credit, default: 0
	  t.float :contributor_creditor_debt, default: 0
	  t.float :contributor_creditor_credit, default: 0
	  t.float :bnp_dollar_debt, default: 0
	  t.float :bnp_dollar_credit, default: 0
	  t.float :abu_dhabi_dollar_debt, default: 0
	  t.float :abu_dhabi_dollar_credit, default: 0
	  t.float :supplier_debt, default: 0
	  t.float :supplier_credit, default: 0
	  t.float :abu_dhabi_euro_debt, default: 0
	  t.float :abu_dhabi_euro_credit, default: 0
	  t.float :other_debt, default: 0
	  t.float :other_credit, default: 0
	  t.integer :year
      t.timestamps null: false
    end
  end
end
