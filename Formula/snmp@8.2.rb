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
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "4c8677afd4f8e3f1f9fb9d441478071f18460cca5e0e02358d991d7895e8cfab"
    sha256 cellar: :any,                 arm64_big_sur:  "967f660fcf37297464663a05227f3dc305436657204bbdbedefa3d259bc86e8d"
    sha256 cellar: :any,                 ventura:        "ffe8194aa8653c3069a44ac342be6f82227e2fef25db6ab1cac9f76c2ebe0335"
    sha256 cellar: :any,                 monterey:       "9de147f0566cfdff4b9919464ee0fa0a298e834cddc8163967d508e10960e8b2"
    sha256 cellar: :any,                 big_sur:        "41ce6b7f6de5295b3c26145b1314d52b9f1ad16ce0663d3de39aa3de7b12d981"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bd2a129025705a6d613a20a6bf714f2113eaf8c28ecd2904b77d45593668dbb3"
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
