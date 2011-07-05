ActiveRecord::Schema.define(:version => 0) do
  create_table :posts, :force => true do |t|
    t.string  :title
    t.text    :body
  end
end