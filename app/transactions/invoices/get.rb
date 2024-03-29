class Transactions::Invoices::Get < Transactions::BaseTransaction
  map :map_params
  step :find_invoices

  private

  def map_params(input)
    params = input.fetch(:params)
    @page = params[:page] || 1
    @start_date = params[:start_date]
    @end_date = params[:end_date]
  end

  def find_invoices
    @invoices = filter_invoices
    Success(invoices_response)
  rescue => e
    # Here i would use a service like Rollbar or Sentry to log the error
    Rails.logger.error(e)
    Failure(error: 'An error occurred while fetching invoices')
  end

  def filter_invoices
    if @start_date.present? && @end_date.present?
      return Invoice
               .where('DATE(invoice_date) BETWEEN ? AND ? ', @start_date, @end_date)
               .order(invoice_date: :asc)
    end
    Invoice.order(invoice_date: :asc)
  end

  def invoices_response
    invoices = @invoices.page(@page).per(15)

    {
      invoices: invoices,
      pagination: {
        total_pages: invoices.total_pages,
        current_page: @page,
        next_page: invoices.next_page,
        prev_page: invoices.prev_page
      }
    }
  end
end