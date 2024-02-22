# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.16.tar.xz"
  sha256 "28cdc995b7d5421711c7044294885fcde4390c9f67504a994b4cf9bc1b5cc593"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "d0364edd3c00e36845ae5ba0b70825eb85d41cec14698e23603eece6dc3e7392"
    sha256 cellar: :any,                 arm64_ventura:  "4ccf3d409f9bd5b315336b3f201425e0ccd386c02567ee0748400833693a561e"
    sha256 cellar: :any,                 arm64_monterey: "e5724713579e27ca6a7cc93b62862adc280c34f62835de42c4fcecc199f7d008"
    sha256 cellar: :any,                 ventura:        "ab9b5911a2ee51cc70e743bf064ff5315d57e3206506779464abbba646c0684e"
    sha256 cellar: :any,                 monterey:       "8f73007879628b6a05619fa7c4e632592f72378547d5e90b9c39b395ad4fba67"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e8ec1628cb170f5eefc7bce7366aa105c669fea6aaac9feec01aca7ffb3c3600"
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
