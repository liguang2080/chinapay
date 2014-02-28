require "chinapay/version"
require 'yaml'
require 'digest/md5'
require 'cgi'

require File.dirname(__FILE__) + '/chinapay/config'

require File.dirname(__FILE__) + '/chinapay/request/tencent'
require File.dirname(__FILE__) + '/chinapay/request/alipay'
require File.dirname(__FILE__) + '/chinapay/response/tencent'
require File.dirname(__FILE__) + '/chinapay/response/alipay'

module Chinapay

  ADAPTER_TYPES = ["alipay", "tenpay", "1002", "1038", "1003", "1052", "1005", "1020", "1024", "1022", "1006", "1008", "1004", "1021", "1009", "1025", "1027", "1032"]

  def self.build_request(adapter, title, total_fee, notify_url, attach)
    adapter = adapter.to_s

    raise "Not vaid chinapay adapter, it should be in #{ADAPTER_TYPES}" unless ADAPTER_TYPES.include?(adapter)

    return Chinapay::Request::Alipay.new(title, total_fee, notify_url, attach, nil) if adapter == "alipay"
    return Chinapay::Request::Tencent.new(title, total_fee, notify_url, attach, '0') if adapter == "tenpay"
    Chinapay::Request::Tencent.new(title, total_fee, notify_url, attach, adapter)
  end

  def self.build_response(params)
    return Chinapay::Response::Tencent.new(params) if params["sp_billno"].present?
    return Chinapay::Response::Alipay.new(params) if params["out_trade_no"].present?
    nil
  end
end

if defined?(Rails)
  require File.dirname(__FILE__) + '/chinapay/railtie'
end
