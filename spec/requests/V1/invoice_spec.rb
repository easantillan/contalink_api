require 'rails_helper'

RSpec.describe V1::InvoicesController, type: :request do
  describe "GET /index" do

    before(:all) { create_list(:invoice, 50) }

    it "returns http success" do
      get "/V1/invoices"
      expect(response).to have_http_status(:success)
    end

    it "returns a list of 25 invoces for the 1st page" do
      get "/V1/invoices"
      json_response = JSON.parse(response.body)
      expect(json_response["invoices"].count).to eq(25)
    end

    it "returns a list of 25 invoces for the 2nd page" do
      get "/V1/invoices", params: { page: 2 }
      json_response = JSON.parse(response.body)
      expect(json_response["invoices"].count).to eq(25)
    end

    it "returns a list of invoices for datas between 2020-01-01 and 2020-12-31" do
      get "/V1/invoices", params: { start_date: "2020-01-01", end_date: "2020-12-31" }
      json_response = JSON.parse(response.body)

      json_response["invoices"].each do |invoice|
        invoice_date = DateTime.strptime(invoice["invoice_date"], "%m/%d/%Y %I:%M %p").to_date
        expect(invoice_date).to be_between(Date.parse("2020-01-01"), Date.parse("2020-12-31"))
      end
    end
  end
end