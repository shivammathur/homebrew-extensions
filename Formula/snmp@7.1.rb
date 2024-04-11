# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/d91d880e29357a238394a912121bc48a6225bd7b.tar.gz"
  version "7.1.33"
  sha256 "cdf3ec0af871a5930a9248d8ae28a444262d64a4674e7d8ab9b714eab82f48fb"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sonoma:   "c37224511fe49b540161d393cb5b003c10c455a4a8ee9a83ce77a2197e2d116e"
    sha256 cellar: :any,                 arm64_ventura:  "f390f1efd1a0ef773da88bf6b4e2aafd0eb0ddefa809e52eb6acac874fd8f18a"
    sha256 cellar: :any,                 arm64_monterey: "671641657d2793aa26ccb865c332f34eab71ba629b397c8b137c91ac93baef41"
    sha256 cellar: :any,                 ventura:        "7148baafad0ee6b23c80c8097e8d5b8f044aebf3532aaba2750edb627e33deb8"
    sha256 cellar: :any,                 monterey:       "bb107d4ce694988c0eba5c3d1231c0a705e6ceccf3874c64d65cb0c6f70cd950"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d0f28ade1a8b49d46dbcb2e8af381e614a1d0dcb283be07ece642a4475bbeb60"
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
