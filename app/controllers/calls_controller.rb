require 'twilio-ruby'

class CallsController < ApplicationController
  skip_before_action :verify_authenticity_token,
                     :only => [:create, :handle_gather, :voicemail, :update]

  def index
    @calls = Call.all
    render "index"
  end

  def create
    call = Call.create(to: params["Caller"],
                       from: params["Called"],
                       call_sid: params["CallSid"],
                       status: params["CallStatus"])
    render xml: VoiceResponse.find_by(name: 'intro').xml
  end

  def handle_gather
    response = response_from_digits params['Digits'].to_i
    render xml: response.xml
  end

  def voicemail
    Call.find_by(call_sid: params["CallSid"])
      .update(voicemail_url: params["RecordingUrl"])
    render xml: VoiceResponse.find_by(name: 'end_voicemail').xml
  end

  def update
    Call.find_by(call_sid: params["CallSid"])
      .update(status: params["CallStatus"],
              duration: params["CallDuration"].to_i)
    head :ok
  end

  private

  def response_from_digits(digits)
    case digits
    when 1
      VoiceResponse.find_by name: 'forward'
    when 2
      VoiceResponse.find_by name: 'voicemail'
    else
      VoiceResponse.find_by name: 'unrecognized_option'
    end
  end

end
