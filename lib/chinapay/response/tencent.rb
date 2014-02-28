# -*- encoding : utf-8 -*-
module Chinapay
  module Response
    class Tencent
      attr_reader :trade_no, :total_fee, :attach, :pay_type

      def initialize(params)
        @cmdno = params["cmdno"] || ''
        @pay_result = params["pay_result"] || ''
        @date = params["date"] || ''
        @transaction_id = params["transaction_id"] || ''
        @sp_billno = (params["sp_billno"] || '').to_i
        @total_fee = params["total_fee"] || ''
        @fee_type = params["fee_type"] || ''
        @attach = params["attach"] || ''

        @sign = params["sign"] || ''

        @bargainor_id = Chinapay.config["tencent"]["parter"]
        @key = Chinapay.config["tencent"]["key"]

        @pay_type = "财付通"
      end

      def total_fee
        @total_fee.to_f / 100
      end

      def trade_no
        @sp_billno
      end

      def successful?
        @pay_result == '0' && @sign.downcase == Digest::MD5.hexdigest(sign_params).downcase
      end

      def sign_params
        "cmdno=#{@cmdno}&pay_result=#{@pay_result}&date=#{@date}&transaction_id=#{@transaction_id}" +
          "&sp_billno=#{@sp_billno}&total_fee=#{@total_fee}&fee_type=#{@fee_type}" +
          "&attach=#{CGI.escape(@attach)}&key=#{@key}"
      end

      def success_response(redirect_url = "")
        strHtml = <<-EOF
        <html>
        <head>
        <meta name="TENCENT_ONLINE_PAYMENT" content="China TENCENT">
        <script language="javascript">
        window.location.href='#{redirect_url}';
        </script>
        </head>
        <body></body>
        </html>
        EOF
      end
    end
  end
end
