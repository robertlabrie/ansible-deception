# this is the ruby skeleton for hosting the ansible deception suites
require 'sinatra'
require 'sinatra/multi_route'
require 'json'
set :server, 'webrick'
route :get, :post, '/*' do
  # puts "#{request.to_yaml}"
  payload = {}
  payload['env'] = request.env
  payload['params'] = request.params
  payload['headerfile'] = '/tmp/header'
  payload['bodyfile'] = '/tmp/body'
  payload['datadir'] = '/Users/robertlabrie/Documents/tmp/deception'

  # handle uploads here
  if request.env['REQUEST_METHOD']
    if params[:file]
      tempfile = params[:file][:tempfile]
      FileUtils.cp(tempfile.path, "/tmp/uploaded")
      payload['tempfile'] = "/tmp/uploaded"
    end
  end
  puts "#{payload.to_json}"
  ansible = `ansible-playbook ansible/main.yml -i local, --connection=local -e '#{payload.to_json}'`
  puts "#{ansible}"

  data = File.read(payload['headerfile'])
  data = JSON.parse(data)
  http_response = data.select { |key, value| key.to_s.match(/^http_response/) }
  http_response.each do |k,v|
    next if k == 'http_response_status'
    n = k.gsub('http_response_','').gsub('__','-')
    headers[n] = v
  end
  status http_response['http_response_status'] if http_response['http_response_status']
  s = File.binread(payload['bodyfile'])
  s
end
