
# Uncomment this line to define a global platform for your project
# platform :ios, '6.0'

source 'https://github.com/CocoaPods/Specs.git'

inhibit_all_warnings!


target :WDNetWorkingTests, :exclusive => true do
# pod 'Kiwi'
end

target 'WDNetWorking' do

pod 'AFNetworking', '~> 3.0'
pod 'OBSlider', '1.1.0'
pod 'PXTools', '~> 1.0.0'


end
post_install do |installer_representation|
installer_representation.pods_project.build_configurations.each do |config|
config.build_settings['SKIP_INSTALL'] = 'YES'
config.build_settings['VALID_ARCHS'] = 'armv7 armv7s arm64'
config.build_settings['ARCHS'] = 'armv7 armv7s arm64'
end
end

