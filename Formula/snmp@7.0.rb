# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/01620e1ea421be6f10360fefc1127e96a9c80467.tar.gz"
  version "7.0.33"
  sha256 "6f801b4bea2dc7025bb09144eb2c63493ab3013c7010d069d8464e88528d29a3"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "c10b1e72fd697c39e5585f193001d406747331f5cf9da72dceac2cc5142e6a5e"
    sha256 cellar: :any,                 arm64_big_sur:  "c6f50d95ab58dfc00a271bd57393fb598d53fa96e35910e56831620d32e50ee6"
    sha256 cellar: :any,                 ventura:        "0700d3054a6f245b1ee2f772a1aa96bc2091a85236fc1c89d5fd54500123f855"
    sha256 cellar: :any,                 monterey:       "211692dc0a7ef4593e70d4f302526b1355a255d311a67412b78db0b7fc69f527"
    sha256 cellar: :any,                 big_sur:        "d8ffd8a08eaa1114c8ffc1477effc296f932a38657ed9abdcc2fa963ece17af1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b6e0071ec1ad42cce9fb235b64c31e739c0fb7bd612c5ddf8f36ce9c02d2de25"
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
