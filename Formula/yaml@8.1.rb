# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT81 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.2.tgz"
  sha256 "119052f0461d57d86f44c252f9c9b2dd743486c701c1a0aba0aebecdd0d8b82a"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "6e93cf841f91e3c7e0b761ff02d27607dd9b92e8068fe1604a230ce67b10b657"
    sha256 cellar: :any,                 big_sur:       "8d282ee93eb5c5212e6153e474019b4e2f242f5eee8ba30ea583b2484c04e6b8"
    sha256 cellar: :any,                 catalina:      "d95723cdcfb6783eedbb57d7173102bc6b4bef767316e89f16a70f0f1eceb589"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b8ec454995f379fa57310f5d4f3945215f3c52f3229ae1970a682a993b884076"
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
