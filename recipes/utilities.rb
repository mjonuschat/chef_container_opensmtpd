# frozen_string_literal: true

#
# Cookbook:: container_opensmtpd
# Recipe:: utilities
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

package %w[certbot python3-certbot-dns-route53 filebeat] do
  action :upgrade
end

cookbook_file '/etc/filebeat/filebeat.yml' do
  source 'filebeat/filebeat.yml'
  owner 'root'
  group 'root'
  mode '0644'
end

runit_service 'filebeat' do
  default_logger true
  start_down true
end

directory '/etc/my_init.d' do
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/my_init.d/certbot' do
  owner 'root'
  group 'root'
  mode '0750'
  source 'certbot/startup.erb'
end

template '/etc/cron.d/certbot' do
  owner 'root'
  group 'root'
  mode '0750'
  source 'certbot/certbot.cron.erb'
end
