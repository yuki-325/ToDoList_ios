# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ToDoList_ios' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # 警告対処
  inhibit_all_warnings!
  
  # Pods for ToDoList_ios
  pod 'MaterialComponents'
  
  target 'ToDoList_iosTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ToDoList_iosUITests' do
    # Pods for testing
  end

end

#警告対処
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
    end
  end
end
