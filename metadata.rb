name              "image-sync"
maintainer        "Abel Lopez"
maintainer_email  "alopgeek@gmail.com"
license           "Apache 2.0"
description       "Glance image-cache sync"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.5"
recipe            "image-sync::default", "Installs/configures btsync for glance"

%w{ debian ubuntu }.each do |os|
  supports os
end

depends "apt"
