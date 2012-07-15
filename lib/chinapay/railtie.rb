# -*- encoding : utf-8 -*-
module Tencentpay
  class Railtie < ::Rails::Railtie
    config.after_initialize do
      Tencentpay::Config.load_config
    end
  end
end
