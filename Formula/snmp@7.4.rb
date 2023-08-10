# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/39cb5f05b2bfaad7008f95e1b49b21005efaa64e.tar.gz"
  version "7.4.33"
  sha256 "1ef8f9836a28715b34645aa9335f66807a510c60cbd0ed3721aa61e2e00002ef"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "29970ca948ee7b21572b304a76303b39e93f64406758d36f6c56bda1670c50c8"
    sha256 cellar: :any,                 arm64_big_sur:  "60748a5e0c282d118c8e74032ccddbb8c9acdd3a051a98b1c534f1110b69c58a"
    sha256 cellar: :any,                 ventura:        "368528ab9e471d3cd3c4bae42b8c24d49c93d72fddebe98034e168b13d22df5d"
    sha256 cellar: :any,                 monterey:       "77d206642d4a448177ae25f7659a9b0fe038668dc78a92ee75794720b6c33872"
    sha256 cellar: :any,                 big_sur:        "eecdcf3aa9001f47d9da6be1ae6234b9da3f8bc6fcad4fba3315ace32d8c7a0b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b9463a535df684047c462da536253942b79ad7683d2fd9f7982f1e14c478248c"
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
