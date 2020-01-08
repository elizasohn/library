class Author
  attr_accessor :name, :id


  def initialize(attributes)
    @name = attributes.fetch(:name) || nil
    @id = attributes.fetch(:id, nil)
  end

  def self.all
    returned_authors = DB.exec('SELECT * FROM authors;')
    authors = []
    returned_authors.each() do |author|
      name = author.fetch('name')
      id = author.fetch('id').to_i
      authors.push(Author.new({:name => name, :id => id}))
    end
    authors
  end

  def self.search(x)
    authors = Author.all
    authors.select {|e| /#{x}/i.match? e.name}
  end

  def save
    result = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end

  def self.clear
    DB.exec("DELETE FROM authors *;")
  end
end
