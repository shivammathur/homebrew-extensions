# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7424bc30ea6ee2385f843dfb23f843b551008d17.tar.gz"
  version "7.4.33"
  sha256 "71139f37f15b8172db13fbebda91829c305d506787e0defd090044ce92c0231e"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "6522d11bd20c8e6baa317fb3213dc59e05d29bd5ecafb0f6a04500df0298d9a5"
    sha256 cellar: :any,                 arm64_big_sur:  "f77555984b23eb232717d6376f66b0a082d540f5b419b11fb00a4bc41e93b9dc"
    sha256 cellar: :any,                 ventura:        "86fb38e2f8b54584a7bfa2e9abd5faf55ef1534915163774e86770fd80f5ffc5"
    sha256 cellar: :any,                 monterey:       "25424252c4ce2dc319c1082055de829ace91f1371770f689f9df397da05d5ff3"
    sha256 cellar: :any,                 big_sur:        "88b35a3ce8ae1c454329ae621119b28c5648153926b88830e956fffbccebe19c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a9c3a56a3e721ac71a00d7ae5e077c1029f60df5d9ce7b2930533abe58d4496b"
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
