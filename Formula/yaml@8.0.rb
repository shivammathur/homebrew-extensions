# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "399e1ffbad90c0292d2c41a4ae9397b9a9de8ba825f10602ed548c57fdbba66d"
    sha256 cellar: :any,                 big_sur:       "4f72361bf477447533a166816d6a40fce9bacb85193f1cb4fded8bb9d946da4c"
    sha256 cellar: :any,                 catalina:      "e7af124725cd36ceedb25ca24c94ca7aae9990b0b59d3cd45efa0a29c5b60be0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6c36e6cd5c7062ec6b04c6c662b932ca35d897eeac6e1f42097f35af8dbf4c65"
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
