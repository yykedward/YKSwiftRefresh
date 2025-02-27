

Pod::Spec.new do |s|
  s.name             = 'YKSwiftRefresh'
  s.version          = '1.4.3'
  s.summary          = 'YKSwiftRefresh'

  s.description      = <<-DESC
                YKSwiftRefresh
                       DESC

  s.homepage         = 'https://github.com/yykedward/YKSwiftRefresh'
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'edward' => 'edward' }
  s.source           = { :git => 'https://github.com/yykedward/YKSwiftRefresh.git', :tag => s.version.to_s }
  

  s.ios.deployment_target = '11.0'

  
  s.default_subspec = 'Core'
    
  s.subspec "Core" do |ss|
    ss.source_files = 'Sources/YKSwiftRefresh/*'
  end
  
end
