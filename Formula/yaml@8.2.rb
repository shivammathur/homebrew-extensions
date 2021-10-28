# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "3a99cd5f774fcd5eba3f4736439053361ace1426fd021eccc645ab4a21dae2ae"
    sha256 cellar: :any,                 big_sur:       "6d2a017684c87320172d8452da67ff7586c4ff736094c5754b4660de0e6cdc92"
    sha256 cellar: :any,                 catalina:      "fa501bce1e7bf1eaa6830ee185556ec4a2d053d5ee8447b29fbf9f8803526f37"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2df23272ceb0fe9a86ad935b03243559ce8d2609a2ad1196ca4f835f1c82e70d"
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
