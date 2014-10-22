#
# Be sure to run `pod lib lint GAIATabPageView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "GAIATabPageView"
  s.version          = "0.2.4"
  s.summary          = "Google Play Like ViewCotroller"
  s.description      = <<-DESC
                       * Google Play Like Tab Paging ViewCotroller
                       * None yet stable version
                       * It was designed to be able to change freely
                       * It might be wise is to use in place of the fork now
                       DESC
  s.homepage         = "https://github.com/Gaia-Murata/GAIATabPageView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Gaia-Murata" => "Soichiro_Murata@voyagegroup.com" }
  s.source           = { :git => "https://github.com/Gaia-Murata/GAIATabPageView.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'GAIATabPageView' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
