# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6cfe49e294414185452ec89bad39b1bd42cc72c9.tar.gz"
  version "5.6.40"
  sha256 "c7aea2d4742a6daadfa333dce1e6707bd648b2ed54e36238674db026e27d43cf"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_tahoe:   "8b24a873466bc5d8a936dc9ef6476daa87839a5fda4fe43701f43c0bbca8401a"
    sha256 cellar: :any,                 arm64_sequoia: "1fb572110c3f4b365ab70beccb433235118623e82eaa37663a67d9d16691629f"
    sha256 cellar: :any,                 arm64_sonoma:  "56e76f5ce911debb7cb878625651b3a55a1b531aeb9f5185bafbc861ebd9247f"
    sha256 cellar: :any,                 sonoma:        "0575e316162a19df89f8f83eb73a747c9a2db238a6de70a472a70607067f194a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ac9537f960219d3caf1d5ec1ff7982a6ffd7a25b4bd4f2dce9eb9e8b29ee5916"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0c03b684b206344e3a772ec294f0c36c7cb556aac345ba885f978a8068805a46"
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
