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
    sha256 cellar: :any,                 arm64_monterey: "9ac241b4552b9459947e275eb983eecb9d41e551fc100a878289ee4e31620611"
    sha256 cellar: :any,                 arm64_big_sur:  "9f9ac349150882d140986b05c30e8a300e6c82125052f1e47570bf4735e1af42"
    sha256 cellar: :any,                 monterey:       "ce1d159343af83b9be76ddd7a9d21899a71fa6c063f3f5e59b7d8c191ed47cd1"
    sha256 cellar: :any,                 big_sur:        "099bb6ca9eefe2bf34ee4646ca04fb0179fe4e14329a4834928299cdbb341626"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9b9dc357ef6087b2048c677d945e97d22d96b62e36f952786e2da105cf40e75d"
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
