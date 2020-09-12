# frozen_string_literal: true

#
# Cookbook:: container_opensmtpd
# Recipe:: repositories
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

## Elastic Filebeat repository
apt_repository 'filebeat' do
  uri "https://artifacts.elastic.co/packages/#{node['container_opensmtpd']['filebeat']['version']}/apt/"
  key 'D88E42B4'
  distribution 'stable'
  components %w[main]
end

## Groovy backports
apt_repository 'groovy-universe' do
  uri 'http://us.archive.ubuntu.com/ubuntu'
  distribution 'groovy'
  components %w[universe]
end

apt_preference 'groovy-universe' do
  package_name '*'
  pin 'release n=groovy'
  pin_priority '-10'
end

apt_preference 'groovy-universe-opensmtpd-filter-rspamd' do
  package_name 'opensmtpd-filter-rspamd'
  pin 'release n=groovy'
  pin_priority '900'
end

apt_preference 'groovy-universe-opensmtpd-filter-senderscore' do
  package_name 'opensmtpd-filter-senderscore'
  pin 'release n=groovy'
  pin_priority '900'
end

## Update apt repository information
apt_update 'refresh' do
  action :update
end
