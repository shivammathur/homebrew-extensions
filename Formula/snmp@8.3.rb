# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/fe6263e2437b312f9a8b685013cf194f31238a38.tar.gz?commit=fe6263e2437b312f9a8b685013cf194f31238a38"
  version "8.3.0"
  sha256 "737465e6ce4872bd72d32622f6ad97b92b9f9fcdee3dc77b8026b5a4946eec8d"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 22
    sha256 cellar: :any,                 arm64_monterey: "e4a804930d7fc9ee9b1679395d5a884eeb264855e78f105116a3aaff8c0b3fc9"
    sha256 cellar: :any,                 arm64_big_sur:  "23ddf0f52d5ef15c96b599a622c4730f1822f5ff21727b53b51c9cde320d98f5"
    sha256 cellar: :any,                 ventura:        "3d6c023fd4c21092064940c79e54db23f864c0fad1066e26b0b5cf3ae3ffd1ac"
    sha256 cellar: :any,                 monterey:       "c537a740691a04aff7f95358e0c7b8583a407d620a6b31ddc4ae628dff3ad87d"
    sha256 cellar: :any,                 big_sur:        "1aa81439489ffc07eca9c97adc564bf01381d4c1c943e7f506578d75717fd855"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fa3058289e7c46dd5c045cf63e3a22b5012cd436c117ff4ae18c1ffc96ef69fa"
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
