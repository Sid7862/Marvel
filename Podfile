# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Marvel' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'Bond'
  pod 'Kingfisher', '~> 6.0'
  pod 'SwiftLint'
  # Pods for Marvel

  target 'MarvelTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MarvelUITests' do
    # Pods for testing
  end

end

use_modular_headers!
inhibit_all_warnings!

pre_install do |installer|
    remove_swiftui()
end

def remove_swiftui
  # 解决 xcode13 Release模式下SwiftUI报错问题
  system("rm -rf ./Pods/Kingfisher/Sources/SwiftUI")
  code_file = "./Pods/Kingfisher/Sources/General/KFOptionsSetter.swift"
  code_text = File.read(code_file)
  code_text.gsub!(/#if canImport\(SwiftUI\) \&\& canImport\(Combine\)(.|\n)+#endif/,'')
  system("rm -rf " + code_file)
  aFile = File.new(code_file, 'w+')
  aFile.syswrite(code_text)
  aFile.close()
end

