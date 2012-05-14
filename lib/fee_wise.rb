require 'httparty'
#require 'debugger'
class FeeWise
  include HTTParty
  format :json

  # secureapi/searchbyzip?publickey=xxxxx&nonce=xxxxx&agentid=xxxxx&format=xxxxx
  def self.find_agentdata_by_agent_id(id)
    publickey=8675308
    timestamp=Time.new.to_i
    agentid=id
    resulttype='json'
    uri = "secureapi/agentdata?publickey=#{publickey}&nonce=#{timestamp}&agentid=#{agentid}&format=#{resulttype}"
    host = "http://dev.leadplace.com/"
    apikey = Gibberish::HMAC("eddb3934207f170654190d816686990187b8ddcab0486b966e36b73fdf", "#{uri}", :digest => :sha256)
    response = get("#{host}#{uri}",:headers => {'APIKEY' => apikey})
    json_response = JSON.load(response.body)
  end

  # Test case for agent data with bad apikey
  # def self.find_agentdata_by_agent_id_and_bad_apikey(id)
  #   publickey=8675308
  #   timestamp=Time.new.to_i
  #   agentid=id
  #   resulttype='json'
  #   uri = "secureapi/agentdata?publickey=#{publickey}&nonce=#{timestamp}&agentid=#{agentid}&format=#{resulttype}"
  #   host = "http://dev.leadplace.com/"
  #   apikey = Gibberish::HMAC("eddb3934207f170654190d816686990187b8ddcab0486b966e36b73fdf", "#{uri}", :digest => :sha256) + "1"
  #   response = HTTParty.get("#{host}#{uri}",:headers => {'APIKEY' => apikey})
  #   json_response = JSON.load(response.body)
  # end

  # secureapi/searchbyzip?publickey=xxxxx&nonce=xxxxx&zipcode=xxxxx&agenttype=xxxxx&format=xxxxx
  def self.find_by_zip(zip)
    publickey=8675309
    timestamp=Time.new.to_i
    zipcode=zip
    agenttype=1
    resulttype='json'
    uri = "secureapi/searchbyzip?publickey=#{publickey}&nonce=#{timestamp}&zipcode=#{zip}&agenttype=#{agenttype}&format=#{resulttype}"
    host = "http://dev.leadplace.com/"
    apikey = Gibberish::HMAC("4c7d682f42663e6d6972296b3c5a233d2d5d624d3a3645792f597b7928", "#{uri}", :digest => :sha256)
    response = get("#{host}#{uri}",:headers => {'APIKEY' => apikey})
    json_response = JSON.load(response.body)
  end

end
