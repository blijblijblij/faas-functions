# Check whether nodes are running
class Handler
  def run(_req)
    logging = Logging.logger(STDOUT)
    logging.info('#############################')
    logging.info 'Checking pods on amd64 arch'
    logging.info Time.now.to_s
    logging.info('#############################')

    auth_options = {
      bearer_token_file: '/var/run/secrets/kubernetes.io/serviceaccount/token'
    }

    ssl_options = {}
    if File.exist?('/var/run/secrets/kubernetes.io/serviceaccount/ca.crt')
      ssl_options[:ca_file] = '/var/run/secrets/kubernetes.io/serviceaccount/ca.crt'
    end

    app_client = Kubeclient::Client.new(
      'https://kubernetes.default.svc/api',
      'v1',
      auth_options: auth_options,
      ssl_options: ssl_options
    )

    # fetch all pods labelled for the nightshift
    pods = app_client.get_pods(label_selector: 'beta.kubernetes.io/arch=amd64')
    pods.each do |p|
      logging.info("#{p.metadata.namespace}: #{p.metadata.name}")
    end
  end
end
