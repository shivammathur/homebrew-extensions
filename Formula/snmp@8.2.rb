# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.23.tar.xz"
  sha256 "81c5ae6ba44e262a076349ee54a2e468638a4571085d80bff37f6fd308e1d8d5"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "edc7dd48597dbe4b53d918fd1e596e0498e628ff37fa4919a2b0051a092f7e9e"
    sha256 cellar: :any,                 arm64_ventura:  "e950e23d74d6687761388f0cf1ecac3e5ffbbf09bb25b61a6e4c4add566fba18"
    sha256 cellar: :any,                 arm64_monterey: "a9e7b64eb2b2f73c4a11dc85dcc3a6793a97f6e92c731a2897ba96c71a410be5"
    sha256 cellar: :any,                 ventura:        "30324b93974b697bcc34a468c34fc4b121330f8f307a2d3764b75881399030b3"
    sha256 cellar: :any,                 monterey:       "b22844aea0d495c7f9b9a099ec77111d06568c345cdfe5a28f16b13b0a0245f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b106edc010acb490a32a9d81e49385242aff6591542100b63721a58c1d3ea74b"
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
