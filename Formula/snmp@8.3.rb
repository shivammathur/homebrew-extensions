# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/94eb3bdcbf34fb61ec66e8f949c86ed66bcbd727.tar.gz?commit=94eb3bdcbf34fb61ec66e8f949c86ed66bcbd727"
  version "8.3.0"
  sha256 "32184f1cd62a950516380bf407cf788e2144dd0bda621e6b02c7ad61b1c5a3c6"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_monterey: "029f8b62e8b0db49dd3400f686363f48ba85b0ba0f24df2c5de3dd3b7e238c2c"
    sha256 cellar: :any,                 arm64_big_sur:  "14e5dd3526afe51897d2a14cec4616100e98aa69a9a30521bb2f40d6391ab206"
    sha256 cellar: :any,                 ventura:        "d1b6ebac01e5b86d593a121119cd368287b3967d2745698de1bd90d7b39699bf"
    sha256 cellar: :any,                 monterey:       "dc92abb6196b431992b169b03345e747c4f5290bde17b923c80fbaad90d2ff76"
    sha256 cellar: :any,                 big_sur:        "1178b8334f1559444aecb883d350e514a2c727f99545a4a2bfc92dd7def3839e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "99d729ae862d356131cd64822565fe2d2de4caa4781a1391af1d5a402da845eb"
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
