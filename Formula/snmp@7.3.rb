# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7ff6ba7443d4691f7c7a2ca3b8f58f3cea632765.tar.gz"
  version "7.3.33"
  sha256 "6610f090bb89e34257bd22c5bf4081c485fbf53362bb1231d09141017198729e"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "ff8aeb46a1612860d5caf955f71e0b565d418587767d988fec756fbb0c54ba0c"
    sha256 cellar: :any,                 arm64_big_sur:  "4c041595a088db6bbbb121954aaf79cbcd106cac9c8d08ac0d3e3ab1235169fb"
    sha256 cellar: :any,                 ventura:        "618d17c05db43fe02b8ce4d9be3ccd85f775cccf9e0a37eaf2c81c3f5448f779"
    sha256 cellar: :any,                 monterey:       "ffdb8b42fe3d11c9b7838aa073b64cbe7d9a5e435c6bd5d538bd4548fe626619"
    sha256 cellar: :any,                 big_sur:        "e6bb0ccfb9387ad567182dc87f99436df7ae76b83a913b474b9a4dad6194d9b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1531680704e5284108d4a922ed736df9470ccfff443a18978ba19139f3f2b6f0"
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
