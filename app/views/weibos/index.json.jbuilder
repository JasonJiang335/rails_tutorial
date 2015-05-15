json.array!(@weibos) do |weibo|
  json.extract! weibo, :id, :content, :user_id
  json.url weibo_url(weibo, format: :json)
end
