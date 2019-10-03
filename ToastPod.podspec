#
# Be sure to run `pod lib lint ToastPod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ToastPod'
  s.version          = '0.3.0'
  s.summary          = 'This is an ios Toast library with swift 4.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  This is an iosToast library. This is an iosToast library. 
                       DESC

  s.homepage         = 'https://gitlab.program.com.tw/AppGroup/ToastPod'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kellychen' => 'kellychen@program.com.tw' }
  s.source           = { :git => 'https://gitlab.program.com.tw/AppGroup/ToastPod.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ToastPod/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ToastPod' => ['ToastPod/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
