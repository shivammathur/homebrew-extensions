# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/3ec3a5352eb55a241b2e22e54e711b24f1542df0.tar.gz"
  version "7.1.33"
  sha256 "68e64a7a50b5649f3236bb39db32aef85a1082345ad266fd0af107d69b53b0ed"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "c507213fcd7993671726b15eaaf4be939077a5a40d14036b7b929b37e092b2fd"
    sha256 cellar: :any,                 arm64_big_sur:  "d5e6316ca20a3d78a636d762fa00dab52da14dc200b44fd136dbfd9af52cc99b"
    sha256 cellar: :any,                 monterey:       "50adb2a22f196e20adb37559bb6dcd23e4cd3e1e0d6e012f2f57046caf0b8c8d"
    sha256 cellar: :any,                 big_sur:        "9ed48a04440fde4024488a5e8be69992defb35adba1fe50d49f458eb649ab96d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bb6d682daf6dc410bc2ccb40beab838be458a0234bced64ac6b48c215f43eecf"
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
