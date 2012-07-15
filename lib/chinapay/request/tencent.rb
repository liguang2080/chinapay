# -*- encoding : utf-8 -*-
module Chinapay
  module Request
    class Tencent
      GATEWAY_URL = "https://www.tenpay.com/cgi-bin/v1.0/pay_gate.cgi"

      def initialize(title, total_fee, notify_url, attach, bank_type)
        @cmdno = 1
        @date  = Date.today.strftime("%Y%m%d")
        @bank_type = bank_type
        @desc = title || "即时到账充值"

        @bargainor_id = Chinapay.config["tencent"]["parter"]
        @key = Chinapay.config["tencent"]["key"]

        @sp_billno = Time.now.to_i + Time.now.tv_usec * 1000 + $$
        @transaction_id = "#{@bargainor_id}#{@date}#{@sp_billno}"

        @total_fee = (total_fee * 100).to_i
        @fee_type = 1

        @return_url = notify_url
        @attach = attach || ''

        @spbill_create_ip = '127.0.0.1'
        @cs = "utf-8"
      end

      def sign
        @sign ||= Digest::MD5.hexdigest(sign_params).downcase
      end

      def sign_params
        "cmdno=#{@cmdno}&date=#{@date}&bargainor_id=#{@bargainor_id}&transaction_id=#{@transaction_id}" +
          "&sp_billno=#{@sp_billno}&total_fee=#{@total_fee}&fee_type=#{@fee_type}" +
          "&return_url=#{@return_url}&attach=#{CGI.escape(@attach)}" +
          "&spbill_create_ip=#{@spbill_create_ip}&key=#{@key}"
          end

      def params
        "cmdno=#{@cmdno}&date=#{@date}&bank_type=#{@bank_type}&desc=#{CGI.escape(@desc)}" +
          "&purchaser_id=&bargainor_id=#{@bargainor_id}&transaction_id=#{@transaction_id}" +
          "&sp_billno=#{@sp_billno}&total_fee=#{@total_fee}&fee_type=#{@fee_type}" +
          "&return_url=#{CGI.escape(@return_url)}&attach=#{CGI.escape(@attach)}" +
          "&spbill_create_ip=#{@spbill_create_ip}&cs=#{@cs}"
          end

      def url
        "#{GATEWAY_URL}?#{params}&sign=#{sign}"
      end
    end
  end
end
