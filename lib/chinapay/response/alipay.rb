# -*- encoding : utf-8 -*-
module Chinapay
  module Response
    class Alipay
      attr_reader :trade_no, :total_fee, :attach, :pay_type

      def initialize(params)
        @params = params
        @trade_no = params["out_trade_no"]
        @total_fee = params["total_fee"].to_f
        @attach = params["extra_common_param"]
        
        @pay_type = "支付宝"
      end

      def successful?
        (@params["trade_status"] == "TRADE_SUCCESS") && (md5_sort(filter_params(@params)) == @params.sign)
      end

      def success_response(redirect_url = "")
        "success"
      end

      private
      def filter_params(params)
        params.dup.delete_if {|k,v| (k == "controller") || (k == "action") || (k == "sign") || (k == "sign_type") || v.blank? }
      end

      def md5_sort(hash)
        Digest::MD5.hexdigest(hash.keys.sort.map {|k| "#{k}=#{hash[k]}"}.join('&') + Chinapay.config["alipay"]["key"]).downcase
      end
    end
  end
end
