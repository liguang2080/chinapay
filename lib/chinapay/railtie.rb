# -*- encoding : utf-8 -*-
module Tencentpay
  class Railtie < ::Rails::Railtie
    initializer "加载rails的配置文件" do
      Chinapay.load_config
    end
  end
end
