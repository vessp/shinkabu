class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def angular
    render 'layouts/application'
  end

  def stocks
    # count = Stock.count
    # Stock.create!({name: "asdf#{count}"})

    # JSON.parse(jsonArray)

    stocks = Stock.all

    # response = HTTP.get("http://localhost:3000/stocks2.json")

    query = "http://query.yahooapis.com/v1/public/yql?q=select%20SYMBOL%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22SU%22%2C%22AAPL%22%2C%22GOOG%22%2C%22MSFT%22)%0A%09%09&env=http%3A%2F%2Fdatatables.org%2Falltables.env&format=json"

    response = HTTParty.get(query)
    
    # puts response.body

    stocks[0].name = JSON.parse(response.body)

    # stocks = [{name: "asdf"}]

    respond_to do |format|

      format.json { render json: stocks }

    end
  end

    def stock

        Tracer.d(params)

        http://query.yahooapis.com/v1/public/yql?q=select symbol from yahoo.finance.quotes where symbol in ("MSFT")&env=http://datatables.org/alltables.env&format=json

        # query = 'http://query.yahooapis.com/v1/public/yql?q=select * from yahoo.finance.quotes where symbol in ("SU","AAPL","GOOG","MSFT")&env=http://datatables.org/alltables.env&format=json'
        query = 'http://query.yahooapis.com/v1/public/yql?q=select * from yahoo.finance.quotes where symbol in ("' + params[:name] + '")&env=http://datatables.org/alltables.env&format=json'
        response = HTTParty.get(query)

        respond_to do |format|

          format.json {
            render json: response
        }

        end
    end

    def stocks2
        respond_to do |format|

          format.json { render json: Stock.all }

        end
    end

end
