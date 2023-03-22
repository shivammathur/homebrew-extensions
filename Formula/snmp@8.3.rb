# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/4fe91fc8614b6de011b5d0c489ce0926a4282883.tar.gz?commit=4fe91fc8614b6de011b5d0c489ce0926a4282883"
  version "8.3.0"
  sha256 "241c0a002f0aaf4a7459973d06761659cf4bf5eea678eab0ce08e005511c4210"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "8ce60bd1cb7b5c53fe574e4f48356b98f7b392c0b5ca622a39559bc667923f68"
    sha256 cellar: :any,                 arm64_big_sur:  "e5d16849307ebb2325ab304d49f3ec720b94620e3c763ada73a837067863ddd7"
    sha256 cellar: :any,                 monterey:       "b43a04b33121ea9f812c7fba3dc026d0c75b5d192138b9d1c1a2561c539ba421"
    sha256 cellar: :any,                 big_sur:        "e0be68a64a8db0a7abddc1dd402e63f60bb5cb0cb06fdc25789524be8f7108b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "aff4ff5472701aa215a33d852e18affc6e045f19ef7d238e309b9cf0050be749"
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
