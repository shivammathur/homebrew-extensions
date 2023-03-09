# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT83 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.3.tgz"
  sha256 "5937eb9722ddf6d64626799cfa024598ff2452ea157992e4e67331a253f90236"
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "ddb6ffeffa48398a3f3ba6d6ee8c26451261faee71e47b5ed8b7516133dc8bb2"
    sha256 cellar: :any,                 arm64_big_sur:  "a0a0a442290e5c166093fed31fe83e734f3db7e44d4d23ad7dac1bf7396fd72f"
    sha256 cellar: :any,                 monterey:       "06d4c316060e151a0947b10e8cb4bbebe84399278150e21ef7b2b065bfaffc86"
    sha256 cellar: :any,                 big_sur:        "67e4d221c52992472b6dc2a4a8edaff0d4977db0a98d71a7148b45aeea305b89"
    sha256 cellar: :any,                 catalina:       "3a5db56d65b3c0ee62e2c252626916deb00bf6fc58ca64b394e38754cb97e510"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "375d8f9d5fdfc726d36fda14214d1a0b46795793d112aadd34a3927cbebb2038"
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
