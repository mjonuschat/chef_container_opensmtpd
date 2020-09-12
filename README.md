# container_opensmtpd Cookbook

This cookbook includes recipes to prepare an image meant to serve as good base for Ruby on Rails web apps.

## Requirements

### Platforms

- Ubuntu 18.04+

May work with or without modification on other Debian derivatives.

### Chef

- Chef 14.5+

### Cookbooks

- None

## Recipes

### default

Configures the system to support running Ruby on Rails web applications out of the box.
It builds on the foundation of `chef_container_baseimage` and assumes some defaults
set in there.

This image is also opinionated in what integrations it provides out of the box:
  - `sidekiq` for background job processing
  - `clockwork` for scheduling recurring application specific jobs
  - `sentry` for error monitoring and release tracking
  - `filebeat` to send `logstash` compatible logs to ElasticSearch
    The following environment variables can be used to configure filebeat:  
    **FILEBEAT_APP_NAME:** Name of the application, used as base for index and template names.  
    **FILEBEAT_ELASTICSEARCH_HOSTS:** Sets the output destination, defaults to _localhost:9200_  

## Maintainers

This cookbook is maintained by Morton Jonuschat <m.jonuschat@mojocode.de>

## License

**Copyright:** 2019, Morton Jonuschat

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
