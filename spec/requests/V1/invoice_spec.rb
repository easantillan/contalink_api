require 'rails_helper'

RSpec.describe V1::InvoicesController, type: :request do
  describe "GET /index" do

    before(:all) { create_list(:invoice, 100) }

    describe "GET /V1/invoices" do

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

      it "returns 0 invoces for the 20th page, since it does not exist" do
        get "/V1/invoices", params: { page: 20 }
        json_response = JSON.parse(response.body)
        expect(json_response["invoices"].count).to eq(0)
      end

      it "returns a list of invoices for datas between 2020-01-01 and 2020-12-31" do
        get "/V1/invoices", params: { start_date: "2020-01-01", end_date: "2020-12-31" }
        json_response = JSON.parse(response.body)

        json_response["invoices"].each do |invoice|
          invoice_date = DateTime.strptime(invoice["invoice_date"], "%m/%d/%Y %I:%M %p").to_date
          expect(invoice_date).to be_between(Date.parse("2020-01-01"), Date.parse("2020-12-31"))
        end
      end

      it "returns unprocessable_entity if the transaction fails" do
        allow_any_instance_of(Transactions::Invoices::Get).to receive(:filter_invoices).and_raise(StandardError)

        get "/V1/invoices", params: { start_date: "2020-01-01", end_date: "2020-12-31" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end