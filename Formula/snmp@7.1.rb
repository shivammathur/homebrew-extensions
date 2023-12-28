# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6c34dd8846d13d06f91a0d1b61bce9a941756831.tar.gz"
  version "7.1.33"
  sha256 "bd305498a5ba9e47fc60ea94fe2bb552e0833fadf04844a17bb68cc75d46eced"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_ventura:  "726e3927bbec7e113524bb00bf86367e88a42160dfe3a85a4c85278199baf1da"
    sha256 cellar: :any,                 arm64_monterey: "6085e227c87800ef6b97b2fde58c6514bdf6c7c851aeb3b9e7df70a2f863fa71"
    sha256 cellar: :any,                 arm64_big_sur:  "1e76dd6485cd1190ce191c2e1bb78be143a1f6872f50ac8380f3bead57d8a9dc"
    sha256 cellar: :any,                 ventura:        "2aebad40645d65465c77cbbd3f885d6e5dd90ae191e1a2895c5f6e3bb871ad7c"
    sha256 cellar: :any,                 monterey:       "8b97541d8ee475878520fc5387db226da2abbc11aac1587de8f2fdf3607df311"
    sha256 cellar: :any,                 big_sur:        "e39f2d3d8eff4025f0b288eb1eff9440c52927f0aaa3261628017fe3951f2729"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f76a2dfb7b4ea38e33d3d04339efd14f6980859b8d0ae4f81ac59d0b180689da"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
