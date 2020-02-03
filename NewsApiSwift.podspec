#
# Be sure to run `pod lib lint NewsApiSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NewsApiSwift'
  s.version          = '0.1.0'
  s.summary          = 'Swift client for NewsApi.org. Search worldwide news with code'

  s.description      = <<-DESC
Get breaking news headlines, and search for articles from over 30,000 news sources and blogs with our news API
                       DESC

  s.homepage         = 'https://github.com/Adobels/NewsApiSwift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Blazej SLEBODA' => 'contact@blazejsleboda.fr' }
  s.source           = { :git => 'https://github.com/Adobels/NewsApiSwift.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'NewsApiSwift/Classes/*'
end
