# Check whether nodes are running
require 'logging'

class Handler
  def run(_req)
    logging.info('#############################')
    logging.info 'Checking pods on amd64 arch'
    logging.info Time.now.to_s
    logging.info('#############################')
  end
end
