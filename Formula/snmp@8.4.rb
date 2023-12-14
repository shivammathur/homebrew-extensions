# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/be46545ee03261d90b3df644dade64b9ed01d21b.tar.gz?commit=be46545ee03261d90b3df644dade64b9ed01d21b"
  version "8.4.0"
  sha256 "43450b6f800048336f37e17304d0c4370640affc8e3f2631352834bebd4ed6a9"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 19
    sha256 cellar: :any,                 arm64_sonoma:   "c66c4ac52dbd649b0258534de51a2686198c81fd6d924190c3335af9bc226eaa"
    sha256 cellar: :any,                 arm64_ventura:  "c06bb1b29e62612f1cf3cf859b770ab296cb4364e8d1ceda5e05cd11ae293431"
    sha256 cellar: :any,                 arm64_monterey: "623e078183df4e90e2f3a3019206dbcb3b3e21505b18075610b6f2707c0e0e21"
    sha256 cellar: :any,                 ventura:        "971414cda35c373afeeaf3a09eceb242bf3208696e3c2fb877e13fc49a6ac6ae"
    sha256 cellar: :any,                 monterey:       "d17e5fc699aa67f78a985e6080c688d1d042fb91197064af7cc9021de8016fe5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "462a042bdfd4ac6c85b691088b5b04514f502b220325bb38eb0a8a785c528717"
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
