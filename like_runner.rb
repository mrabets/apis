require 'net/http'
require 'json'

def toggle_like(token, unlike = false)
  uri = URI('http://localhost:3000/api/v1/photos/17/likes')
  req = unlike ? Net::HTTP::Delete.new(uri) : Net::HTTP::Post.new(uri)
  req['Authorization'] = 'Bearer ' + token

  res = Net::HTTP.start(uri.hostname, uri.port) {|http|
    http.request(req)
  }

  res.body
end

def like_photo(token)
  like = true

  loop do
    begin
      data = JSON.parse(toggle_like(
        token,
        like
      ))

      like = !like
    rescue Exception => e
      puts "=====ERROR=====: #{e}"
      exit 1
    else
      puts data
      # sleep 0.01
    end
  end
end

threads = []

threads << Thread.new {
  like_photo("eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjM5NjQyNjMyLCJleHAiOjE2NDA5Mzg2MzIsImp0aSI6ImU3Y2NjZTUzLWIwNGItNGM5Zi05YTIyLTM4Zjg3OWVmMDIyYSJ9.7DNPuh25lHtgw9kv_JUlvWQuJPOFhJs7hJyJ9uH-p9A")
}

threads << Thread.new {
  like_photo("eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjM5NjQ0NTY3LCJleHAiOjE2NDA5NDA1NjcsImp0aSI6IjI4Njg3ODZhLTNkYTMtNGJiNi05MWE3LWZmYjRlOGM2NzcwZSJ9.ZE5GDUOS0lcWfdfN_eQDXJ0MbACIepP37gX_VE-scRY")
}

threads << Thread.new {
  like_photo("eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjM5NjQ0NTk0LCJleHAiOjE2NDA5NDA1OTQsImp0aSI6IjIxMjk3YzdhLWVmYzMtNGU0OS04ZDBkLWZiNzQxZGQ0MmJlZiJ9.MzcZbTrvD5UJktwDeLVSNo2ba2D33V7mX87uH52-LEU")
}

threads.each(&:join)
