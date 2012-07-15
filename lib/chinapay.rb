require "chinapay/version"
require 'yaml'
require 'digest/md5'
require 'cgi'

require File.dirname(__FILE__) + '/chinapay/request/tencent'
require File.dirname(__FILE__) + '/chinapay/request/alipay'
require File.dirname(__FILE__) + '/chinapay/response/tencent'
require File.dirname(__FILE__) + '/chinapay/response/alipay'

module Chinapay
  def self.build_request(adapter, title, total_fee, notify_url, attach, bank_type = '0')
    "Chinapay::Request::#{adapter.to_s.classify}".safe_constantize.new(title, total_fee, notify_url, attach, bank_type)
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
