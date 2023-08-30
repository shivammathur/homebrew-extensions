# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT84 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.3.tgz"
  sha256 "5937eb9722ddf6d64626799cfa024598ff2452ea157992e4e67331a253f90236"
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "b1b145f474aa515b2ba2211d8f3fcd83a378980455e3a12025f32427747c960f"
    sha256 cellar: :any,                 arm64_big_sur:  "fe5071cddb3eb470e86a63d4149188f31435a091c649990167761f25b6f3e723"
    sha256 cellar: :any,                 ventura:        "b18c988ec1e2cd32b4b1d7e721691d9863ca45717e1cc940cd72e809d767fa0f"
    sha256 cellar: :any,                 monterey:       "e7ceb984fbaabe70108358fc1ad856ec1ff2d742463c98c769b43f18a5bba7bd"
    sha256 cellar: :any,                 big_sur:        "e7a1c8b8f49b81eb682e2b0b7dba10e26584b5370792b2da3520e0b8976e9d2e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "615192dc10690251436e6b4eb53e4564185ed1496d2ed0b6dda253936ede4b59"
  end

  depends_on "libyaml"

  def install
    args = %W[
      --with-yaml=#{Formula["libyaml"].opt_prefix}
    ]
    Dir.chdir "yaml-#{version}"
    inreplace "detect.c", "ZEND_ATOL(*lval, buf)", "*lval = ZEND_ATOL(buf)"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
