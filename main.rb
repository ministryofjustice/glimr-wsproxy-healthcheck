require 'sinatra'
require 'json'
require 'glimr_api_client'

get '/:healthcheck' do |collection_ref|
  checks = healthchecks
  body({
    service_status: checks[:service_status],
    dependencies: {
      glimr_status: checks[:glimr_status]
    }
  }.to_json)
  status(checks[:service_status] == 'ok' ? 200 : 502)
end


def healthchecks
  service_status = if glimr_available
                     'ok'
                   else
                     'failed'
                   end
  {
    service_status: service_status,
    glimr_status: service_status
  }
end

def glimr_available
  GlimrApiClient::Available.call.available?
rescue GlimrApiClient::Unavailable
  false
end
