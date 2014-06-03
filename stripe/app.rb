require 'sinatra'
require 'stripe'

class Application < Sinatra::Application

  get "/" do
    erb :index
  end

  post "/process" do
    Stripe.api_key = "sk_test_BQokikJOvBiI2HlWgH4olfQ2"

    begin
      charge = Stripe::Charge.create(
        amount: 1000, # amount in cents, again
        currency: "usd",
        card: params["stripeToken"],
        description: "payinguser@example.com"
      )
      "Payment successful"
    rescue Stripe::CardError => e
      "Payment unsuccessful"
    end
  end
end
