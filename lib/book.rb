class Book
  attr_accessor :name, :id, :author_id


  def initialize(attributes)
    @name = attributes.fetch(:name) || nil
    @id = attributes.fetch(:id, nil)
    @author_id = attributes.fetch(:author_id, nil)
  end

  def self.all
    returned_books = DB.exec('SELECT * FROM books;')
    books = []
    returned_books.each() do |book|
      name = book.fetch('name')
      id = book.fetch('id').to_i
      author_id = book.fetch('author_id').to_i
      books.push(Book.new({:name => name, :id => id, :author_id => author_id}))
    end
    books
  end

  def self.search(x)
    books = Book.all
    books.select {|e| /#{x}/i.match? e.name}
  end

  def save
    result = DB.exec("INSERT INTO books (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(book_to_compare)
    self.name() == book_to_compare.name()
  end

  def self.clear
    DB.exec("DELETE FROM books *;")
  end

  def self.find(id)
    book = DB.exec("SELECT * FROM books WHERE id = #{id};").first
    name = book.fetch("name")
    id = book.fetch("id").to_i
    Book.new({:name => name, :id => id})
  end
  # 
  # def self.find_by_author(id)
  #   results = DB.exec("SELECT * FROM authors_books WHERE author_id = #{id};")
  #   books = []
  #   results.each {|result|
  #     book_id = result.fetch('book_id')
  #     book = DB.exec("SELECT * FROM books WHERE id = #{book_id};").first
  #     name = book.fetch("name")
  #     id = book.fetch("id").to_i
  #     books.push(Book.new({:name => name, :id => id}))
  #   }
  #   books
  # end


  def update(name)
    @name = name
    DB.exec("UPDATE books SET name = '#{@name}' WHERE id = #{@id}")
  end

  def delete
    DB.exec("DELETE FROM books WHERE id = #{@id};")
    DB.exec("DELETE FROM books WHERE author_id = #{@id};")
  end

  def self.sort()
    books = Book.all
    books.sort { |a, b| a.name <=> b.name }
  end

  #   def songs
  #   Song.find_by_album(self.id)
  # end

  # def artists
  #   Artist.find_by_album(self.id)
  # end
  #

end


#
#  def ==(book_to_compare)
#   if book_to_compare != nil
#     (self.name() == book_to_compare.name()) && (self.book_id() == book_to_compare.book_id())
#   else
#     false
#   end
# end
