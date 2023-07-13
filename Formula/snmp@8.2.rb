# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.8.tar.xz"
  sha256 "cfe1055fbcd486de7d3312da6146949aae577365808790af6018205567609801"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "35ce924821480475ea7dc2efd1568ec4e414e453977e135aeca96c2a62c9adcd"
    sha256 cellar: :any,                 arm64_big_sur:  "f2b5f2ba800a4b0d3fdb8802f03452e2dd6431cad6e2d6bfc3ef8670d1a81edc"
    sha256 cellar: :any,                 ventura:        "aad376589749426d0cbfe93204eba88ea1c636b2f541e0d03077db44be5ab3a6"
    sha256 cellar: :any,                 monterey:       "51a4de40de979f64474ca17a12958952a41929db4b6d8b1e3135c78c6a05a29e"
    sha256 cellar: :any,                 big_sur:        "2c032d24a4f0bf9242c7382f6b48fcfbd3a811bd5652de04b96f4cd1c66b0e8d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "56ee3b42e11ad3e0e0b49ffd8bd16848a99dd3e019bc465655d66119c4a9a7a2"
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
