class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    def angular
        render 'layouts/application'
    end

    def stocks
        respond_to do |format|
          format.json { render json: Stock.all.order('symbol ASC') }
        end
    end


    def stock
        Tracer.d("--/stock.json--")
        Tracer.d(params)

        # http://query.yahooapis.com/v1/public/yql?q=select symbol from yahoo.finance.quotes where symbol in ("MSFT")&env=http://datatables.org/alltables.env&format=json
        # query = 'http://query.yahooapis.com/v1/public/yql?q=select * from yahoo.finance.quotes where symbol in ("SU","AAPL","GOOG","MSFT")&env=http://datatables.org/alltables.env&format=json'

        query = 'http://query.yahooapis.com/v1/public/yql?q=select * from yahoo.finance.quotes where symbol in ("' + params[:symbol] + '")&env=http://datatables.org/alltables.env&format=json'
        response = HTTParty.get(query)

        respond_to do |format|
            format.json { render json: response }
        end
    end

end
