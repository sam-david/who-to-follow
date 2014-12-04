category_array = ["tech","music","sports","photo","entertainment","news","fashion","food","television","movies","family","art","business","finance","health","books","science","faith","government","social_good","travel","gaming","nba","nfl","mlb","nascar","nhl","pga"]

category_array.each do |category|
  Category.create(name: category)
end