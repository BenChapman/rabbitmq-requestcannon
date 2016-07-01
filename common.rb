require 'bunny'
require 'json'

def rabbitmq_creds(name)
  return nil unless ENV['VCAP_SERVICES']

  JSON.parse(ENV['VCAP_SERVICES'], :symbolize_names => true).values.map do |services|
    services.each do |s|
      begin
        return s[:credentials][name.to_sym]
      rescue Exception
      end
    end
  end
  nil
end

def client
  unless $client
    begin
      verify_peer_value = (ENV["RABBITMQ_SKIP_SSL"] != "1")
      c = Bunny.new(:verify_peer => verify_peer_value, :addresses => rabbitmq_creds('hostnames'), :username => rabbitmq_creds('username'), :password => rabbitmq_creds('password'), :vhost => rabbitmq_creds('vhost'))
      c.start
      $client = c.create_channel
    rescue Exception => e
      puts "ERR:#{e}"
    end
  end
  $client
end

def queue
	client.queue("bunny.examples.hello_world")
end

def exchange
	client.default_exchange
end
