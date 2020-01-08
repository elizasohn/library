require 'spec_helper'
require 'rspec'
require 'book'

describe '#Book' do

  describe('#==') do
    it("is the same book if it has the same attributes as another book") do
      book = Book.new({:name => "48 Laws of Power", :id => nil})
      book.save()
      book2 = Book.new({:name => "48 Laws of Power", :id => nil})
      book2.save()
      expect(book).to(eq(book2))
    end
  end

  describe(".all") do
    it("returns an empty array when there are no books") do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a book") do
      book = Book.new({:name => "Green Eggs and Ham", :id => nil})
      book.save()
      book2 = Book.new({:name => "The Wizard of Oz", :id => nil})
      book2.save()
      expect(Book.all).to(eq([book, book2]))
    end
  end
  #
  describe('.clear') do
    it("clears all books") do
      books = Book.new({:name => "Green Eggs and Ham", :id => nil})
      books.save()
      books2 = Book.new({:name => "The Wizard of Oz", :id => nil})
      books2.save()
      Book.clear()
      expect(Book.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an book by id") do
      book = Book.new({:name => "Lorrie Moore", :id => nil})
      book.save()
      book2 = Book.new({:name => "Amy Hempel", :id => nil})
      book2.save()
      expect(Book.find(book.id)).to(eq(book))
    end
  end

  describe('#update') do
    it("updates an book by id") do
      book = Book.new({:name => "As A Man Thinketh", :id => nil})
      book.save()
      book.update("The Unbearable Lightness of Being")
      expect(book.name).to(eq("The Unbearable Lightness of Being"))
    end
  end

  describe('#delete') do
    it("deletes an book by id") do
      book = Book.new({:name => "The Philosophy THE Hunger Games", :id => nil})
      book.save()
      book2 = Book.new({:name => "Camera Lucida", :id => nil})
      book2.save()
      book.delete()
      expect(Book.all).to(eq([book2]))
    end
  end
  #
  # describe('.search') do
  #   it("Searches for matching books by name") do
  #     book1 = Book.new({:name => "Gabriel Garcia Marquez", :id => nil})
  #     book1.save()
  #     book2 = Book.new({:name => "Vladimir Nabokov", :id => nil})
  #     book2.save()
  #     book3 = Book.new({:name => "Milan Kundera", :id => nil})
  #     book3.save()
  #
  #     expect(Book.search("Milan")).to(eq([book3]))
  #   end
  # end
  #
  # describe('.sort') do
  #   it('sorts by alphebetical order') do
  #     book1 = Book.new({:name => "Pablo Neruda", :id => nil})
  #     book1.save()
  #     book2 = Book.new({:name => "E. E. Cummings", :id => nil})
  #     book2.save()
  #     book3 = Book.new({:name => "Robert Asimov", :id => nil})
  #     book3.save()
  #     expect(Book.sort()).to(eq([book2, book1, book3]))
  #   end
  # end
end
