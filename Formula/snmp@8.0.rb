# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/1bb9988fd6c151c783653e3a2257c1a0897e6633.tar.gz"
  sha256 "1969f16cab5dbf112b0f1115279d061f29f63d8910cc56c497cff59c853f9f6c"
  version "8.0.30"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_tahoe:   "320019272667c0cb9aca7ac413059580a182e4f297a888a564f711e92a2af7a2"
    sha256 cellar: :any, arm64_sequoia: "40658f08417c054b200537df76cb18c4d100d4a4f096448a6eee52ca8dfe6880"
    sha256 cellar: :any, arm64_sonoma:  "34773e6d95232735621872853d2f993d7d5d434385d372a8020fccaa1b81e548"
    sha256 cellar: :any, sonoma:        "4bcbaa8ce56dc48bf207ba287fd3ac14c74d475426af3e9091f9b754bfb6e5f0"
    sha256 cellar: :any, arm64_linux:   "a8439d917dcf8e6e041b8ab3b8d22e7560904e146a7f120434ef4161814370d9"
    sha256 cellar: :any, x86_64_linux:  "bf9693f851a408309cb8fbbab292b3bc2ca1dc1b17595807ec543d9df34c75eb"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
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
