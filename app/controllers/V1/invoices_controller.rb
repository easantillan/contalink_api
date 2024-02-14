class V1::InvoicesController < ApplicationController
  def index
    Transactions::Invoices::Get.call(params: params) do |m|
      m.success do |result|
        render json: PaginatedInvoicesSerializer.new(result).as_json
      end
      m.failure do |error|
        render json: error, status: :unprocessable_entity
      end
    end
  end
end