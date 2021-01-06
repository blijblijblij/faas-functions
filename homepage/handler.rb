require 'figlet'

class Handler
  def run(body, _headers)
    status_code = 200 # Optional status code, defaults to 200
    response_headers = { 'content-type' => 'text/plain' }

    logging = Logging.logger(STDOUT)
    logging.info('#############################')
    logging.info 'Some logging from the installed logging gem'
    logging.info('#############################')

    body = "Hello world from the Ruby template #{Time.now} \n"

    [body, response_headers, status_code]
  end
end
