# -*- encoding : utf-8 -*-
module Chinapay
  module Request
    class Alipay
      GATEWAY_URL = "https://mapi.alipay.com/gateway.do?"

      def initialize(title, total_fee, notify_url, attach, bank_type)
        @title = title
        @total_fee = total_fee
        @notify_url = notify_url
        @attach = attach
      end


      def url
        sign_parameters = {
          :service => "create_direct_pay_by_user",
          :partner => Chinapay.config["alipay"]["parter"],
          :_input_charset => "utf-8",
          :return_url => @notify_url,
          :notify_url => @notify_url,
          :out_trade_no => Time.now.to_i + Time.now.tv_usec * 1000 + $$,
          :subject => @title,
          :payment_type => 1,
          :seller_email => Chinapay.config["alipay"]["seller"],
          :total_fee => @total_fee,
          :extra_common_param => @attach
        }

        url_parameters = sign_parameters.merge(:sign_type => "MD5", :sign => md5_sort(sign_parameters)).map {|k, v| "#{k}=#{CGI.escape(v.to_s)}"}.join('&')
        "https://mapi.alipay.com/gateway.do?" + url_parameters
      end



      private
      def md5_sort(hash)
        Digest::MD5.hexdigest(hash.keys.sort.map {|k| "#{k}=#{hash[k]}"}.join('&') + Chinapay.config["alipay"]["key"]).downcase
      end

    end
  end
end
