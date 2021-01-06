require 'figlet'

class Handler
  def run(body, _headers)
    status_code = 200 # Optional status code, defaults to 200
    response_headers = { 'content-type' => 'text/plain' }
    font = Figlet::Font.new('big.flf')
    figlet = Figlet::Typesetter.new(font)
    body = "Hello world from the Ruby template #{Time.now} \n"
    body << "#{figlet['hello world']} from the figlet gem"
    [body, response_headers, status_code]
  end
end
