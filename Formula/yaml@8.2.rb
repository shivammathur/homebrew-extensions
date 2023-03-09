# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT82 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.3.tgz"
  sha256 "5937eb9722ddf6d64626799cfa024598ff2452ea157992e4e67331a253f90236"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "601934dd4a261915d7237d82e3d9c92f8b37f0516eb9ea4fcf2401aa1d58ee77"
    sha256 cellar: :any,                 arm64_big_sur:  "50bda997b6b4fbf82da903bb2f5d04c46261240305db9d05ab5af786e7b211e9"
    sha256 cellar: :any,                 monterey:       "723affbe2f8e96251a2423a26b534c41ecf321714616d8249d89a1b75af2d7b3"
    sha256 cellar: :any,                 big_sur:        "0c0c2163ca05ea5816cc75beddb4f9ed86faefa14e296e8c5ac2476881ebb219"
    sha256 cellar: :any,                 catalina:       "cdf69baf2e9fa68f04c5cd64a8319475b9fbfcba3e14366ddd5c0fc1ec55b3b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "25c6c434179851b52de7bcd34e8ababf53029b7789ef737b78c723ea41e1c207"
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
