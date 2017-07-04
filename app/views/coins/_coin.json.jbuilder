json.extract! coin, :id, :name, :ticker, :description, :team, :created_at, :updated_at
json.url coin_url(coin, format: :json)
