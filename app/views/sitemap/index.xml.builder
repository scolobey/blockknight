base_url = "http://#{request.host_with_port}/"

xml.instruct! :xml, :version=>"1.0"
xml.tag! 'urlset', 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9', 'xmlns:image' => 'http://www.google.com/schemas/sitemap-image/1.1', 'xmlns:video' => 'http://www.google.com/schemas/sitemap-video/1.1' do
  for coin in @coins do
   xml.url do
     xml.loc coin_path(coin)
     xml.lastmod coin.updated_at.to_date
     xml.changefreq "monthly"
     xml.priority "0.5"
   end
 end
end
