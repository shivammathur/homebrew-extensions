# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7b23b9111203a96db10f8da71dccb2285d872d8c.tar.gz"
  version "5.6.40"
  sha256 "f63340f5ed259c1ed1efcc2c935dee875c77f2ffb778bc11ca2572e099108451"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "f74ab277588dcbe7c54e35a635c33db0754f31067bfc8893288d9c846f62eddd"
    sha256 cellar: :any,                 arm64_big_sur:  "7e067a85f6352f6a53bfbe3158602e07050d261631b0e4b80064e9386c666832"
    sha256 cellar: :any,                 ventura:        "3a84c7abe276d6924f1f453fe14eb99c7cae818e0b941c2db50a74604f2afa9a"
    sha256 cellar: :any,                 monterey:       "06fce4f63ea5f9b09d821e56cfb939cd7c36909eaa014ad401bc30fcafb2872d"
    sha256 cellar: :any,                 big_sur:        "7504659f28bcfe8989fece835d0274e1ab9fd8960067bd716fcde22a214add08"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2662ce1baa41790f60a4f592414e5146c378ab6f0b93d7fbbdf9719a35ff5eeb"
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
