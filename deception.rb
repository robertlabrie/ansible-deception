# this is the ruby skeleton for hosting the ansible deception suites
require 'sinatra'
require 'json'
get '/*' do
  # puts "#{request.to_yaml}"
  payload = {}
  payload['env'] = request.env
  payload['params'] = request.params
  payload['headerfile'] = '/tmp/header'
  payload['bodyfile'] = '/tmp/body'
  puts "#{payload.to_json}"

  # `ansible-playbook ansible/main.yml -i local, --connection=local -e '{"headerfile":"/tmp/header","bodyfile":"/tmp/body","REQUEST_PATH":"/foo.txt"}'`
  ansible = `ansible-playbook ansible/main.yml -i local, --connection=local -e '#{payload.to_json}'`
  puts "#{ansible}"
  s = File.binread(payload['bodyfile'])
  s
end
