storage_info = if ENV['VCAP_SERVICES']
                 directory = JSON.parse(ENV['VCAP_APPLICATION'])["application_name"]
                 JSON.parse(ENV['VCAP_SERVICES'])['Object-Storage'].first
               else
                 yaml_parsed = YAML.load File.read('config/carrierwave.yml')
                 directory = yaml_parsed['folder']
                 yaml_parsed
               end

credentials = storage_info['credentials'].with_indifferent_access

openstack_creds =  {
  openstack_auth_url:     "#{credentials[:auth_url]}/v3/auth/tokens",
  openstack_api_key:      credentials[:password],
  openstack_project_id:   credentials[:projectId],
  openstack_userid:       credentials[:userId],
  openstack_username:     credentials[:username],
  openstack_domain_name:  credentials[:domainName],
  openstack_region:       credentials[:region],
  openstack_auth_omit_default_port: true
}

fog_connection = Fog::Storage::OpenStack.new(openstack_creds)

begin
  fog_connection.get_container(directory)
rescue Fog::Storage::OpenStack::NotFound
  fog_connection.put_container(directory, public: true)
end

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = openstack_creds.merge(provider: 'openstack')
  config.fog_directory  = directory
  config.fog_public     = true
end
