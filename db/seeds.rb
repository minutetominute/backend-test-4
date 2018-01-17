# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'twilio-ruby'

intro_response = Twilio::TwiML::VoiceResponse.new do |r|
  r.say 'Hello! Thanks for calling Vandalay Industries!'
  r.gather :numDigits => '1',
           :action => '/calls/handle-gather',
           :method => 'get' do |g|
    g.say "To speak to a human, press 1.
           To leave a message, press 2.
           Thank you and have a nice day!"
  end
end

unrecognized_option_response = Twilio::TwiML::VoiceResponse.new do |r|
  r.say 'I don\'t recognize that option.'
end

voicemail_response = Twilio::TwiML::VoiceResponse.new do |r|
  r.say 'Sending you to voicemail.'
  r.record :playBeep => true,
           :method => 'post',
           :action => '/calls/voicemail',
           :maxLength => 30
end

forward_response = Twilio::TwiML::VoiceResponse.new do |r|
  r.dial number: '+12102878805'
  r.say 'The call failed or the remote party hung up. Goodbye.'
end

end_voicemail_response = Twilio::TwiML::VoiceResponse.new do |r|
  r.say 'Thank you. I\'ll reach out to you shortly'
end

VoiceResponse.create(name: "intro", xml: intro_response.to_s)
VoiceResponse.create(name: "forward", xml: forward_response.to_s)
VoiceResponse.create(name: "voicemail", xml: voicemail_response.to_s)
VoiceResponse.create(name: "unrecognized_option", xml: unrecognized_option_response.to_s)
VoiceResponse.create(name: "end_voicemail", xml: end_voicemail_response.to_s)
