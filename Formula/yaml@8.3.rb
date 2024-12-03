# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT83 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.4.tgz"
  sha256 "8eb353baf87f15b1b62ac6eb71c8b589685958a1fe8b0e3d22ac59560d0e8913"
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "8757078c1fd2566962fdd849e5dc4e274deafb624ebb16af7c7f4df23c9ecd90"
    sha256 cellar: :any,                 arm64_ventura:  "d49ef6313a0eaf6fd6047618701944d7d0cd17b946d6c002e3193a1a8bbeea63"
    sha256 cellar: :any,                 arm64_monterey: "6c658a4398435a998750e6a358f6835fd7f49ec8fe0a89e4fb5226c9a24c56b4"
    sha256 cellar: :any,                 arm64_big_sur:  "ee324542350f575399a21b074a77cc56e6b2d9e5a1d8a4616a78933f5d262c6d"
    sha256 cellar: :any,                 ventura:        "d318743db55d14a6b41c027a3fd0cc6a8bfcfe2781c1e43266c6628f5a31001e"
    sha256 cellar: :any,                 monterey:       "3ec70f330948f4a86cdc3bfa923ada1029f10f8562e5da5aa03d1b6293821adc"
    sha256 cellar: :any,                 big_sur:        "c8194701374fd63dd28b726c5b56f3118e25c8c2a91cb6053c3660837cbac4d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "716e1eeefca1c875076a492c639312bd9ceea0c7d7071116e03d0aef7e4dc8a3"
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
