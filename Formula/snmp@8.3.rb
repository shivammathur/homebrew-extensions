# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/bad529870754ee0e214d6eea99a7f0ba42f44a03.tar.gz?commit=bad529870754ee0e214d6eea99a7f0ba42f44a03"
  version "8.3.0"
  sha256 "23873fd083a30132e10c71c8ed2e7a74b9833f13d1f119b2f58db43c79ce6b90"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_monterey: "07f6de0b6e38ce0745e7813cb648ca37a13948b8d52111fe684ae3a86c4ddbd0"
    sha256 cellar: :any,                 arm64_big_sur:  "f7e52816b9c13fc2422a4b696dae802571127383a59ced03cca52dc09bae7dd2"
    sha256 cellar: :any,                 ventura:        "4e3e9bd6e3b648d86bbb6239af8d5920137e7fddb3f11b2f2faefdd143a3df5a"
    sha256 cellar: :any,                 monterey:       "c725d17d948bd2b9eab04477b9f9876443ce6b46b12ed840753b3cd8a70b82ce"
    sha256 cellar: :any,                 big_sur:        "0faa7c6c0fbad09327b711cb4720e79e149aaa41e54bafbc2ed58a64357594e1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "db657a84cd1dadbb2b0b6a43b5f591ee8204e96fe55e92da1cebb757c61120f7"
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
