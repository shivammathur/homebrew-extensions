# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/90d58fc0f49b4a777caa489d59ff7b6b6620ba04.tar.gz"
  version "7.4.33"
  sha256 "65f5056dfacd4fe03f0642cee9e5a7c31b6710679f661b24e0497a4cd46c3b6c"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_ventura:  "90e35e46dfb0a9386e4a2a720159f7ec458ccc8dd4c0f0572cd6365108166425"
    sha256 cellar: :any,                 arm64_monterey: "8aa43b8547951400ce2eb27bb04cf9623e3740ee2be9d5a307e107f5fc43dff2"
    sha256 cellar: :any,                 arm64_big_sur:  "4aa191b6eee39249e582c2c614d5574dbe887019615c85826fa77d13c2c10059"
    sha256 cellar: :any,                 ventura:        "3bb073af731dfbd07ce7514b180fad6caa81d885e876fa579cc2dd5faaae04fa"
    sha256 cellar: :any,                 monterey:       "46c628ae0a706d58859b1dee1cfecc5e46ee9fd9b19767593c668fc000c6d0ae"
    sha256 cellar: :any,                 big_sur:        "621249f24046700c8ae55cc3f8346d0d247bf51797c8604970da5cc4f7bb3b8e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f7c239b35e2bdc7b820144d674a94ebdcfc6cbcddccfdec2d3c980459b3e2a2b"
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
