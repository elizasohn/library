require 'spec_helper'
require 'rspec'
require 'book'

describe '#Author' do
    describe('#==') do
      it("is the same author if it has the same attributes as another author") do
        author = Author.new({:name => "Jean Paul Sartre", :id => nil})
        author.save()
        author2 = Author.new({:name => "Jean Paul Sartre", :id => nil})
        author.save()
        expect(author).to(eq(author2))
      end
    end

    describe(".all") do
      it("returns an empty array when there are no authors") do
        expect(Author.all()).to(eq([]))
      end
    end

    describe('#save') do
      it("saves an author") do
        author = Author.new({:name => "Dr. Seuss", :id => nil}) # nil added as second argument
        author.save()
        author2 = Author.new({:name => "John Redfield", :id => nil}) # nil added as second argument
        author2.save()
        expect(Author.all).to(eq([author, author2]))
      end
    end

    describe('.clear') do
      it("clears all authors") do
        authors = Author.new({:name => "Dr. Seuss", :id => nil})
        authors.save()
        authors2 = Author.new({:name => "John Redfield", :id => nil})
        authors2.save()
        Author.clear()
        expect(Author.all).to(eq([]))
      end
    end

end
