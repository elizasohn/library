require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

before(:each) do
  Album.clear()
  Book.clear()
end

describe('create an author path', {:type => :feature}) do
  it('creates an author and then goes to the author page') do
    visit('/authors')
    click_on('Add a new author')
    fill_in('author_name', :with => 'Roland Barthes')
    click_on('Go!')
    expect(page).to have_content('Roland Barthes')
  end
end

describe('create book path', {:type => :feature}) do
  it('creates an author and then goes to the author page') do
    author = Author.new("Roland Barthes", nil)
    author.save
    visit("/authors/#{author.id}")
    fill_in('book_name', :with => 'Mythologies')
    click_on('Add book')
    expect(page).to have_content('Mythologies')
  end
end
