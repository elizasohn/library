require('sinatra')
require('sinatra/reloader')
require('./lib/author')
require('./lib/book')
require('pry')
also_reload('lib/**/*.rb')
require('pg')

DB = PG.connect({:dbname => 'library'})

get('/test') do
  @something = "this is a variable"
  erb(:whatever)
end

get('/') do
  @authors = Author.all
  @books = Book.all
  erb(:index)
end

get ('/books') do
  if params["search"]
    @books = Book.search(params[:search])
  elsif params["sort"]
    @books = Book.sort()
  else
    @books = Book.all
  end
  erb(:books)
end

get('/authors/new') do
  erb(:new_author)
end

post('/authors') do
  author = Author.new({:name => params[:author_name], :id => nil})
  author.save()
  @authors = Author.all()
  erb(:authors)
end

get ('/authors') do
  if params["search"]
    @authors = Author.search(params[:search])
  elsif params["sort"]
    @authors = Author.sort()
  else
    @authors = Author.all
  end
  erb(:authors)
end

get('/authors/:id') do
  @author = Author.find(params[:id].to_i())
  erb(:author)
end

get('/authors/:id/books/:book_id') do
  @book = Book.find(params[:id].to_i())
  erb(:book)
end

post('/authors/:id') do
  @author = Author.find(params[:id].to_i())
  book = Book.new({:name => params[:book_name], :author_id => params[:id].to_i, :id => nil})
  book.save()
  @author.add_book(params[:book_name])
  erb(:author)
end


get('/books/new') do
  erb(:new_book)
end

post('/books') do
  puts params
  book = Book.new({:name => params[:book_name], :id => nil})
  book.save()
  @books = Book.all() # Adding this line will fix the error.
  erb(:books)
end

get('/books/:id') do
  @book = Book.find(params[:id].to_i())
  erb(:book)
end


#
# get('/authors/:id/edit') do
#   @album = Album.find(params[:id].to_i())
#   erb(:edit_album)
# end
#
# patch('/albums/:id') do
#   @album = Album.find(params[:id].to_i())
#   values = *params.values
#   @album.update(params)
#   @albums = Album.all
#   erb(:albums)
# end

#
# get('/authors/new') do
#   erb(:new_artist)
# end
#
#



# patch('/artists/:id') do
#   @artist = Artist.find(params[:id].to_i())
#   values = *params.values
#   @artist.update(params)
#   @artists = Artist.all
#   erb(:artists)
# end
#
# delete('/albums/:id') do
#   @album = Album.find(params[:id].to_i())
#   @album.delete()
#   @albums = Album.all
#   erb(:albums)
# end
#
# delete('/artists/:id') do
#   @artist = Artist.find(params[:id].to_i())
#   @artist.delete()
#   @artists = Artist.all
#   erb(:artists)
# end
# get('/custom_route') do
#   "We can even create custom routes, but we should only do this when needed."
# end
#
# # Get the detail for a specific song such as lyrics and songwriters.
# get('/albums/:id/songs/:song_id') do
#   @song = Song.find(params[:song_id].to_i())
#   erb(:song)
# end
#
# # Post a new song. After the song is added, Sinatra will route to the view for the album the song belongs to.
# post('/albums/:id/songs') do
#   @album = Album.find(params[:id].to_i())
#   song = Song.new(:name => params[:song_name], :album_id => @album.id, :id => nil)
#   song.save()
#   erb(:album)
# end
#
# # Edit a song and then route back to the album view.
# patch('/albums/:id/songs/:song_id') do
#   @album = Album.find(params[:id].to_i())
#   song = Song.find(params[:song_id].to_i())
#   song.update(params[:name], @album.id)
#   erb(:album)
# end
#
# # Delete a song and then route back to the album view.
# delete('/albums/:id/songs/:song_id') do
#   song = Song.find(params[:song_id].to_i())
#   song.delete
#   @album = Album.find(params[:id].to_i())
#   erb(:album)
# end
