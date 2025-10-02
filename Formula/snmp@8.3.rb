# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.26.tar.xz"
  sha256 "2f522eefa02c400c94610d07f25c4fd4c771f95e4a1f55102332ccb40663cbd2"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "2478f196c5fbc62ee2c9977bac8dbb42fd9c010e95b5e9266f479e1f6c523400"
    sha256 cellar: :any,                 arm64_sequoia: "18046518f84ec0d2795ad377d2b04c5c62e680687202479e6110406aeb0d5194"
    sha256 cellar: :any,                 arm64_sonoma:  "3d5be4383ab81594dbeb03ecf35a200b46cd83c7cd1dda4741fd630222460f9f"
    sha256 cellar: :any,                 sonoma:        "6a43748c29464ed0e3014e7643bd9fa882d10eb3d29acb70714c770f65028405"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "917cad6eb48256144f6956c251dc8c2beef9d89114f24b4c714662de1577ff6c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6bff8745f8498683cac311b742dbc85a21b5c9ae6f2b9bf9e184ea090b52a4a7"
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
