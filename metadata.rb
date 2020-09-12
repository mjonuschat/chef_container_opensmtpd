# frozen_string_literal: true

name 'container_opensmtpd'
maintainer 'Morton Jonuschat'
maintainer_email 'm.jonuschat@mojocode.de'
license 'Apache-2.0'
description 'Configures a Docker/Rkt/LXC image for forward-only mail service.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.0.1'

recipe 'container_opensmtpd::default', 'Create a docker image with OpenSMTPD in forward-only mode (with DMARC & SRS).'

%w[ubuntu debian].each do |os|
  supports os
end

depends 'apt', '>= 7.1.1'
depends 'runit', '>= 4.3.0'

source_url 'https://github.com/mjonuschat/chef_container_opensmtpd'
issues_url 'https://github.com/mjonuschat/chef_container_opensmtpd/issues'
chef_version '>= 14.5' if respond_to?(:chef_version)
