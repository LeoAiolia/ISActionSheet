#
# Be sure to run `pod lib lint ISActionSheet.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ISActionSheet'
  s.version          = '0.3.0'
  s.summary          = '自定义弹框.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "自定义actionSheet弹框，仿微信和系统，解决系统弹框在ipad运行崩溃的问题，已兼容iPhonex、iphoneXs Max、iPhoneXR"

  s.homepage         = 'https://github.com/LeoAiolia/ISActionSheet'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license      = "MIT"
  s.author           = { 'LeoAiolia' => 'a936381813@163.com' }
  s.source           = { :git => 'https://github.com/LeoAiolia/ISActionSheet.git', :tag => "#{s.version}" }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.platform     = :ios
  s.ios.deployment_target = '8.0'

  s.source_files = "ISActionSheet","ISActionSheet/**/*.{h,m}"
  
  # s.resource_bundles = {
  #   'ISActionSheet' => ['ISActionSheet/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
