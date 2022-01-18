module PostsHelper
  def bubble_style
    "animation: tweet-bubble #{rand(10..20)}s #{rand(0..10)}s; left: #{rand(20..80)}vw;"
  end
end
