# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/8128d17cc2668a6a9810fb0cc5b27fdb54c63f2e.tar.gz?commit=8128d17cc2668a6a9810fb0cc5b27fdb54c63f2e"
  version "8.4.0"
  sha256 "8afdba9d5c456e6bf0075682ea8ed89c407f7bdbabdbffd78565e0c170e7d64e"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 24
    sha256 cellar: :any,                 arm64_sonoma:   "118d4359b5e1bc5355c434782fe825e68e8c3b7fed223a157e45f5b0666b6754"
    sha256 cellar: :any,                 arm64_ventura:  "db0df68c21984412a5128ab35a9705fb20e0fab23e31e54cf2755f02792e4d0a"
    sha256 cellar: :any,                 arm64_monterey: "a95d22640479763362d9bb3d6ce7ff51865982c9fed2edb3b1cf4fe82794d31c"
    sha256 cellar: :any,                 ventura:        "0eb22010817f19b2749c42586aa4c91b282182475434af9cca49f87dd71c0ab4"
    sha256 cellar: :any,                 monterey:       "78debf22f7e76d2101537c38e426cc940f031fa6f4df389659c160125b9b328e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c72f653c8217448a1f3fe968f84e8c4c36b2942946449a05dc05926661bd7032"
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
