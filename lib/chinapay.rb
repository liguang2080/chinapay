require "chinapay/version"
require 'yaml'
require 'digest/md5'
require 'cgi'

require File.dirname(__FILE__) + '/chinapay/request/tencent'
require File.dirname(__FILE__) + '/chinapay/request/alipay'
require File.dirname(__FILE__) + '/chinapay/response/tencent'
require File.dirname(__FILE__) + '/chinapay/response/alipay'

module Chinapay
  # 配置采用统一的 parter_id key seller
  begin
    # filename = "#{Rails.root}/config/chinapay.yml"
    filename = File.expand_path(File.dirname(__FILE__) + "/../chinapay.yml")
    CONFIG = YAML.load(File.open(filename))
  rescue Exception => e
    puts <<-EXAMPLE
      ---
      tencent:
        parter: 1211116701
        key: 3b46d59ae2095e6d9d0f95e4f510e962
        seller: 1211116701
      alipay:
        parter: 1211116701
        key: 3b46d59ae2095e6d9d0f95e4f510e962
        seller: lg2046@gmail.com
    EXAMPLE
    raise "Please configure your Chinapay settings in #{filename}."
  end
  
  
  def self.build_request(adapter, title, total_fee, notify_url, attach, bank_type = '0')
    "Chinapay::Request::#{adapter.to_s.classify}".safe_constantize.new(title, total_fee, notify_url, attach, bank_type)
  end
  
  def self.build_response(params)
    return Chinapay::Response::Tencent.new(params) if params["sp_billno"].present?
    return Chinapay::Response::Alipay.new(params) if params["out_trade_no"].present?
    nil
  end
end