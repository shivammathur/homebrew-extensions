# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.26.tar.xz"
  sha256 "54747400cb4874288ad41a785e6147e2ff546cceeeb55c23c00c771ac125c6ef"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "f080035fc3e25d78dd67b191e2ed185484f136425befbde0c790bd8fd6826eb1"
    sha256 cellar: :any,                 arm64_sonoma:  "88ed1066c5f91a79c3e050d73fcf189fde3a5be1e8ec01cb9d93fa302b9ba9a8"
    sha256 cellar: :any,                 arm64_ventura: "c20f4d83b095db3e883ca134d165af773753fdd781d23244bf644eb26ccd0f9c"
    sha256 cellar: :any,                 ventura:       "2fb44fe7445e0190152b880c9db461d38e90da76584e212da55708f475049c68"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e4cf4a98f49096f9bee9a6ad03355ac01c83acd21a6bdf0763523e326498298c"
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
