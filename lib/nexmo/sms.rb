# frozen_string_literal: true

module Nexmo
  class SMS < Namespace
    include Keys

    def send(params)
      if @client.autodetect_type? && !params[:type]
        params[:type] = unicode?(params[:text]) ? 'unicode' : 'text'
      end

      charset = params[:type] && params[:type] == 'text' ? 'iso-8859-1' : 'utf-8'

      request('/sms/json', params: hyphenate(params), type: Post, charset: charset)
    end

    private

    def unicode?(string)
      string.chars.any? { |c| c.bytes.count != 1 }
    end

    def host
      'rest.nexmo.com'
    end
  end
end
