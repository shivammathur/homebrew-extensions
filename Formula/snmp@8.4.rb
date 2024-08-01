# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/28a7c6243c7bae49f6262b12425e8521abecec2a.tar.gz?commit=28a7c6243c7bae49f6262b12425e8521abecec2a"
  version "8.4.0"
  sha256 "d206820ef639abee34fb3359bbb3f8528fbb227f0cb31f6690f737c508b8cb4e"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 53
    sha256 cellar: :any,                 arm64_sonoma:   "1f34a24dc2329e75023d7bf31048d3170f44cec24f12fb99631ede4bf36a2221"
    sha256 cellar: :any,                 arm64_ventura:  "fd07bd51204c88b38658f4cb49f7100fe26aa22da26e16f997683bc406ee2130"
    sha256 cellar: :any,                 arm64_monterey: "8ce6eabb25b8c134132a30984c7c5fa9f9b4a0f3e3a55d25a73502b0ae504984"
    sha256 cellar: :any,                 ventura:        "937d022add3a8748403afbf6e0e2707829663b3fd655c64f72f5617fe87912d5"
    sha256 cellar: :any,                 monterey:       "4e7dbf030daf54383243a1281937095f515310009323d34e46fae5bff44adabf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7aafa5a6cb9770df1f0e514b2e3ea4965d6ec542180e210b9be25fce1e229a7d"
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
