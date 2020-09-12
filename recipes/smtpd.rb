# frozen_string_literal: true

#
# Cookbook:: container_opensmtpd
# Recipe:: rails
#
# Copyright:: 2020, Morton Jonuschat <m.jonuschat@mojocode.de>
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package %w[opensmtpd opensmtpd-extras redis rspamd opensmtpd-filter-rspamd opensmtpd-filter-senderscore] do
  action :upgrade
end

directory '/etc/mail' do
  action :create
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/smtpd.conf' do
  source 'opensmtpd/smtpd.conf.erb'
end

template '/etc/mail/vdomains' do
  source 'opensmtpd/vdomains.erb'
end

template '/etc/mail/vusers' do
  source 'opensmtpd/vusers.erb'
end

file '/etc/mail/aliases' do
  action :create_if_missing
end

file '/etc/mail/passwds' do
  action :create_if_missing
end

runit_service 'rspamd' do
  default_logger true
  start_down true
end

runit_service 'opensmtpd' do
  default_logger true
  start_down true
end

directory '/etc/mail/dkim' do
  action :create
end

node['container_opensmtpd']['opensmtpd']['vdomains'].each do |domain|
  execute "openssl-dkim-#{domain}-private-key" do
    command "openssl genrsa -out /etc/mail/dkim/#{domain}.key 1024"
    creates "/etc/mail/dkim/#{domain}.key"
  end

  execute "openssl-dkim-#{domain}-public-key" do
    command "openssl rsa -in /etc/mail/dkim/#{domain}.key -pubout -out /etc/mail/dkim/#{domain}_pub.key"
    creates "/etc/mail/dkim/#{domain}_pub.key"
  end

  file "/etc/mail/dkim/#{domain}.key" do
    owner 'root'
    group '_rspamd'
    mode '0440'
  end
end

template '/etc/rspamd/local.d/dkim_signing.conf' do
  owner 'root'
  group 'root'
  mode '0644'
  source 'rspamd/dkim_signing.conf.erb'
end
