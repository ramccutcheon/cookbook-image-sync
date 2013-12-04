Description
===========

Installs and configures btsync for Glance image-cache syncing

Requirements
============

Cookbooks
---------

The following cookbooks are dependencies

* apt

Usage
=====

Requires the creation of a 34-character alphanumeric secret
can be created via `btsync-daemon --generate-secret`
This is expected to be an encrypted data bag as such:

    id: btsync
    key: YOURPRIVATEKEY

License and Author
==================

Author:: Abel Lopez (<alopgeek@gmail.com>)
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

