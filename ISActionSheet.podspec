#
# Be sure to run `pod lib lint ISActionSheet.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ISActionSheet'
  s.version          = '0.5.0'
  s.summary          = '自定义弹框.'

  s.description      = "自定义actionSheet弹框，仿微信和系统，解决系统弹框在ipad运行崩溃的问题，已兼容iPhonex、iphoneXs Max、iPhoneXR"

  s.homepage         = 'https://github.com/LeoAiolia/ISActionSheet'
  s.license      = "MIT"
  s.author           = { 'LeoAiolia' => 'a936381813@163.com' }
  s.source           = { :git => 'https://github.com/LeoAiolia/ISActionSheet.git', :tag => "#{s.version}" }

  s.platform     = :ios
  s.ios.deployment_target = '9.0'

  s.source_files = 'ISActionSheet/*.{h,m}'
  
end
