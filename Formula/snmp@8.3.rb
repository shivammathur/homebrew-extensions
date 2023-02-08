# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/3ff8333473f79fe8255fd2e0781cd3477ebe6a25.tar.gz?commit=3ff8333473f79fe8255fd2e0781cd3477ebe6a25"
  version "8.3.0"
  sha256 "466af1dcdb8f660c1b4f4aec364834328ba68ecee978c08ed4ffa2e885d4c539"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "2482a3cd48a819f60ff9cf3e8a357cf128f2b540fe278338dfbf566510e0dc06"
    sha256 cellar: :any,                 arm64_big_sur:  "aff8ef6c1ca39e723954ca9a3c5877ef4a977477475ab03fe65901ee01a7efd4"
    sha256 cellar: :any,                 monterey:       "f3d70d58fcac34f76fe9c0b3a58acc7bce84bc322db9ae54bd2a879dae15ac85"
    sha256 cellar: :any,                 big_sur:        "65c30bc6652917363bb3c6538b2ffcf3af9c61bde6c52741bbb64d2f332ce90a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "983991921116eb619c8f88c1176141a9de058a0750bcd10af5e922f2d9c2f0db"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
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
