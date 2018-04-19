source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target 'BCSampleSwift' do
	pod 'BeaconCtrl', :git => "https://github.com/VentaApps/BeaconControl_iOS_SDK.git", :branch => :master
end

pre_install do |installer|
    # workaround for #3289
Pod::Installer::Xcode::TargetValidator.send(:define_method, :verify_no_static_framework_transitive_dependencies) {}
end
