require 'sinatra'
require 'paymill'

class Application < Sinatra::Application

  get "/" do
    erb :index
  end

  post "/process" do
    Paymill.api_key = "84a182e2b95d5e32d921fee31d4f0f6a"

    if (( payment = Paymill::Payment.create(token: params["paymillToken"]) ))
      if (( client = Paymill::Client.create(email: 'john@example.com', description: "An awesome guy") ))
        "Payment success"
      else
        Paymill::Transaction.create({
            amount: 2000,
            currency: "USD",
            client: client.id,
            payment: payment.id,
            description: "A transaction"
        })
      end
    else
      "Could not create payment"
    end
  end
end
