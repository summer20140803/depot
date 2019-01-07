Order.transaction do
  (1..5).each do |i|
    Order.create(name: "Custom #{i}", address: "#{i} Main Street",
                 email: "Customer-#{i}.@example.com", pay_type: "Check")
  end
end