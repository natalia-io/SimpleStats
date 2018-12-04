Pod::Spec.new do |s|
  s.name             = 'SimpleStats'
  s.version          = '0.0.1'
  s.summary          = 'Calculate statistical functions easily and quickly. No new classes, only extensions.'
  s.description      = <<-DESC
'Simple, easy-to-use Array and Dictionary extensions to calculate statistics such as average, median, standard deviation, standard error, variance, covariance, confidence intervals, correlation coefficients, etc.'
                       DESC
  s.homepage         = 'https://github.com/natalia-io/simplestats'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Natália Mendonça' => 'natalia@smartmood.io' }
  s.source           = { :git => 'https://github.com/natalia-io/simplestats.git', :tag => 'v0.0.1' }
  s.social_media_url = 'https://www.facebook.com/axiomaticdoubts'

  s.ios.deployment_target = '8.0'
  s.swift_version = '4.2'

  s.source_files = 'SimpleStats/SimpleStats.swift'
  
end
