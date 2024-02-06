describe 'HTTParty' do
  # URL não deterministica
  # it 'HTTParty', vcr: { cassette_name: "jsonplaceholder/posts", match_requests_on: [:body] } do
  it 'HTTParty', vcr: { cassette_name: "jsonplaceholder/posts", :record => :new_episodes } do
    # stub_request(:get, 'https://jsonplaceholder.typicode.com/posts/13').to_return(
    #   status: 200,
    #   body: '',
    #   headers: {
    #     'content-type': 'application/json'
    #   }
    # )

    # Nome no cassete onde vais er guardado todos essas requisições
    # response = HTTParty.get("https://jsonplaceholder.typicode.com/posts/#{[1, 2, 3, 4, 5].sample}")
    response = HTTParty.get("https://jsonplaceholder.typicode.com/posts/7")
    header = response.headers['content-type']
      expect(header).to match(%r{application/json})
  end
end
