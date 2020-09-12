# frozen_string_literal: true

#
# Cookbook:: container_opensmtpd
# Recipe:: default
#
# Copyright:: 2020, Morton Jonuschat <m.jonuschat@mojocode.de>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['container_opensmtpd']['filebeat']['version'] = 'oss-7.x'

default['container_opensmtpd']['certbot']['email'] = 'postmaster@example.com'

default['container_opensmtpd']['opensmtpd']['mailname'] = node['hostname']
default['container_opensmtpd']['opensmtpd']['listen'] = '::'
default['container_opensmtpd']['opensmtpd']['srs_key'] = 'SETME'
default['container_opensmtpd']['opensmtpd']['vdomains'] = %w[
  example.com
  example.org
]

default['container_opensmtpd']['opensmtpd']['vusers'] = {
  'mail@example.com' => 'mail@example.org'
}
