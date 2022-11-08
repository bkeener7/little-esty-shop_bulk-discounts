require 'rails_helper'

RSpec.describe "Merchant Invoice Show Page" do

  before :each do
    @merchant1 = Merchant.create!(name: 'Marvel')
    @customer1 = Customer.create!(first_name: 'Peter', last_name: 'Parker')

    @item1 = Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 100, merchant_id: @merchant1.id)

    @invoice1 = Invoice.create!(status: 'completed', customer_id: @customer1.id, created_at: Time.parse('19.07.18'))

    InvoiceItem.create(quantity: 5, unit_price: 100, status: 'packaged', item_id: @item1.id, invoice_id: @invoice1.id)
    InvoiceItem.create(quantity: 15, unit_price: 100, status: 'packaged', item_id: @item2.id, invoice_id: @invoice1.id)
  end

  describe "As a merchant" do
    describe "When I visit my merchant's invoice show page(/merchants/merchant_id/invoices/invoice_id)" do
      it "Then I see information related to that invoice including: Invoice id, Invoice status, Invoice created_at date in the format 'Monday, July 18, 2019', Customer first and last name" do
        visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"
        # save_and_open_page

        expect(page).to have_content("ID: #{@invoice1.id}")
        expect(page).to have_content("Status: #{@invoice1.status}")
        expect(page).to have_content("Created: Thursday, July 18, 2019")
        expect(page).to have_content("Customer: #{@invoice1.customer.full_name}")
      end
    end
  end
end