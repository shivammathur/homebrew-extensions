# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/06964ab13987c3bdd38c981c87710b8fbebafc5b.tar.gz?commit=06964ab13987c3bdd38c981c87710b8fbebafc5b"
  version "8.3.0"
  sha256 "8df5ef997a76501ee5810f8f089eea2fcbc360b16fe81be3751295f8b5975e88"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 16
    sha256 cellar: :any,                 arm64_sonoma:   "8093c34b8d3f3591cf1847d1841582c42634c3187830cf67a7c246feec8c9281"
    sha256 cellar: :any,                 arm64_ventura:  "e96e2db309cfbb11fd7b7f86f4c823263a7de6d5204786a13e8300565548be9b"
    sha256 cellar: :any,                 arm64_monterey: "f21a259cd367c60c8ab1c79c1c56ce096eab8837dbdbc179b8148505142e8c8e"
    sha256 cellar: :any,                 ventura:        "dc1ecdf29a5650477e8198ebb9ba12b34793324fb01dfe98b686df95ef1cd5d4"
    sha256 cellar: :any,                 monterey:       "a99f350b8e083b1830ed62395371e9fe2e4816aacece25dab70a1a7b5bcea64a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b586dd4960b5d17e51982738cfaf868d389a8c692b14c8ada91b7d807396619b"
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
