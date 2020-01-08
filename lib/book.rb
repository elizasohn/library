class Book
  attr_accessor :name, :id, :genre, :author_id


  def initialize(attributes)
    @name = attributes.fetch(:name)

  end



  def ==(book_to_compare)
   if book_to_compare != nil
     (self.name() == book_to_compare.name()) && (self.author_id() == book_to_compare.author_id())
   else
     false
   end
 end
end
