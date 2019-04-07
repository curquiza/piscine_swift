#
# Be sure to run `pod lib lint curquiza2019.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'curquiza2019'
  s.version          = '0.1.0'
  s.summary          = 'article manager'
  s.swift_version    = '4.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Methods :
- get
- get all
- update
- create
- delete
                       DESC

  s.homepage         = 'https://www.42.fr/'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Clementine Urquizar' => 'clementine.urquizar@gmail.com' }
  s.source           = { :git => 'https://github.com/Clementine Urquizar/curquiza2019.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  #s.source_files = 'curquiza2019/Classes/**/*'

  s.source_files = 'curquiza2019/**/*.{h,m,swift,xcdatamodeld}'
  #s.resources = 'curquiza/Classes/curquiza2019*.xcdatamodeld'
  
  #s.source_files  = 'curquiza2019/Classes/article.xcdatamodeld', 'curquiza/Classes/article.xcdatamodeld/*.xcdatamodel'
  #s.resources = [ 'curquiza2019/Classes/article.xcdatamodeld','curquiza2019/Classes/article.xcdatamodeld/*.xcdatamodel']
  #s.preserve_paths = 'curquiza2019/Classes/article.xcdatamodeld'
  
  # s.resource_bundles = {
  #   'curquiza2019' => ['curquiza2019/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit', 'CoreData'
  # s.dependency 'AFNetworking', '~> 2.3'
end
