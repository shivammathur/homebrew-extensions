# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/8c84e4ab015127711d096c461c3ec661dcd8c925.tar.gz"
  version "7.1.33"
  sha256 "4aa6a4d33f4a67fb92f64f7b264b84cd3b81993443bce3b358e1b15acd7e67e4"
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
