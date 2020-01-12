base = "https://cards.kbn.one"
suits = %w[D C H S]
nums =%w[A 2 3 4 5 6 7 8 9 T J Q K]

suits.each do |s|
  nums.each do |n|
    html =<<~END
      <html>
        <head>
          <meta property="og:image" content="#{base}/#{s}/#{n}.svg" />
        </head>
        <body>
          <img src="#{n}.svg" />
        </body>
      </html>
    END
    open "public/#{s}/#{n}.html", "w" do |f|
      f.puts html
    end
  end
end

