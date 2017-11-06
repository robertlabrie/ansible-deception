# this is the ruby skeleton for hosting the ansible deception suites
require 'sinatra'
require 'sinatra/multi_route'
require 'json'
get '/*' do
#route :get, :post, '/*' do
  # puts "#{request.to_yaml}"
  payload = {}
  payload['env'] = request.env
  payload['params'] = request.params
  payload['headerfile'] = '/tmp/header'
  payload['bodyfile'] = '/tmp/body'
  puts "#{payload.to_json}"
  # request.env.REQUEST_PATH == '/upload'
  # request.env.REQUEST_METHOD == 'POST'
  # `ansible-playbook ansible/main.yml -i local, --connection=local -e '{"headerfile":"/tmp/header","bodyfile":"/tmp/body","REQUEST_PATH":"/foo.txt"}'`
  ansible = `ansible-playbook ansible/main.yml -i local, --connection=local -e '#{payload.to_json}'`
  puts "#{ansible}"
  s = File.binread(payload['bodyfile'])
  s
end

post '/upload' do
  if params[:file]
    tempfile = params[:file][:tempfile]
    FileUtils.cp(tempfile.path, "/tmp/uploaded")
  end
  "the upload the upload what what the upload"
end
