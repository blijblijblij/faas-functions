# Check whether nodes are running

require 'kubeclient'

class Handler
  def run(_req)
    puts('#############################')
    puts 'Checking pods on amd64 arch'
    puts Time.now.to_s
    puts('#############################')

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
      puts("#{p.metadata.namespace}: #{p.metadata.name}")
    end
  end
end
