# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.27.tar.xz"
  sha256 "479e65c3f05714d4aace1370e617d78e49e996ec7a7579a5be47535be61f0658"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "3b574c4af181fe27d0aa1fee7b9325d312ed44ea821c34beca3a879222730a7d"
    sha256 cellar: :any,                 arm64_ventura:  "54c6b5b854d3ae9f46d69828f3545432b96ddac2c72129948d30953535138b69"
    sha256 cellar: :any,                 arm64_monterey: "1c4f2aa3489e64211582aeb58d6349b022120ec16e2ab0f1e17ff764581c0c4f"
    sha256 cellar: :any,                 ventura:        "52f439d597f366daac0f66ae7eeb643d4ae3024747a3770c7c180d4df87bb10a"
    sha256 cellar: :any,                 monterey:       "f256b2b850d8b00d619dcb93b09670004816b5b0f7eadad8fc7734c9345e8cf2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ffb37a24998527ab89ee2213af77ac92c83a5cfbd401437b92d84e4d490f6e7a"
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
