class Post < ApplicationRecord

  validates_uniqueness_of :post_id 

  def to_json
    if body
      yajl = Yajl::Parser.new
      yajl.parse(self.body)
    end 
  end
end