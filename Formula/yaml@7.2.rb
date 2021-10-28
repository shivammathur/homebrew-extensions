# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT72 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.2.tgz"
  sha256 "119052f0461d57d86f44c252f9c9b2dd743486c701c1a0aba0aebecdd0d8b82a"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "f817be9791e5a5b06b2d81e045657dc7c2a6b97dabd1ae417ad621e279148ad2"
    sha256 cellar: :any,                 big_sur:       "915723685a80309be7ea3909ccc5cc06b1b5cf0c2e98eddafa7af123175f0261"
    sha256 cellar: :any,                 catalina:      "5aa2166f91ce657f3a1beaaa3a0083f1f1e0764f18a20d28f96e30a359796a9c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "58bc4d2e0d2c3c30672d50220df9088cf39369674d32a0085b7b880ce91a2ebe"
  end

  depends_on "libyaml"

  def install
    args = %W[
      --with-yaml=#{Formula["libyaml"].opt_prefix}
    ]
    Dir.chdir "yaml-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
