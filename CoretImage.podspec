Pod::Spec.new do |s|
  s.name             = 'CoretImage'
  s.version          = '0.1.0'
  s.summary          = 'Coret is indonesian language, the meaning is like stroke, scratch'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/alifu/CoretImage'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'alifu' => 'alif.bangets@gmail.com' }
  s.source           = { :git => 'https://github.com/alifu/CoretImage.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'CoretImage/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CoretImage' => ['CoretImage/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
