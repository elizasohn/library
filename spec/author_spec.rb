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

    describe('.find') do
      it("finds an author by id") do
        author = Author.new({:name => "Lorrie Moore", :id => nil})
        author.save()
        author2 = Author.new({:name => "Amy Hempel", :id => nil})
        author2.save()
        expect(Author.find(author.id)).to(eq(author))
      end
    end

    describe('#update') do
      it("updates an author by id") do
        author = Author.new({:name => "Kurt Vonnegut", :id => nil})
        author.save()
        author.update("Mr. Kurt Vonnegut")
        expect(author.name).to(eq("Mr. Kurt Vonnegut"))
      end
    end

    describe('#delete') do
      it("deletes an author by id") do
        author = Author.new({:name => "Herman Melville", :id => nil})
        author.save()
        author2 = Author.new({:name => "Sylvia Plath", :id => nil})
        author2.save()
        author.delete()
        expect(Author.all).to(eq([author2]))
      end
    end

    describe('.search') do
      it("Searches for matching authors by name") do
        author1 = Author.new({:name => "Gabriel Garcia Marquez", :id => nil})
        author1.save()
        author2 = Author.new({:name => "Vladimir Nabokov", :id => nil})
        author2.save()
        author3 = Author.new({:name => "Milan Kundera", :id => nil})
        author3.save()

        expect(Author.search("Milan")).to(eq([author3]))
      end
    end

    describe('.sort') do
      it('sorts by alphebetical order') do
        author1 = Author.new({:name => "Pablo Neruda", :id => nil})
        author1.save()
        author2 = Author.new({:name => "E. E. Cummings", :id => nil})
        author2.save()
        author3 = Author.new({:name => "Robert Asimov", :id => nil})
        author3.save()
        expect(Author.sort()).to(eq([author2, author1, author3]))
      end
    end

    # describe('#songs') do
    #   it("returns an album's songs") do
    #     album = Album.new({:name => "Giant Steps", :id => nil})
    #     album.save()
    #     song = Song.new({:name => "Naima", :album_id => album.id, :id => nil})
    #     song.save()
    #     song2 = Song.new({:name => "Cousin Mary", :album_id => album.id, :id => nil})
    #     song2.save()
    #     expect(album.songs).to(eq([song, song2]))
    #   end
    # end
end
