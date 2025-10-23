# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/d378dce3e9c7384e6c1d1492175ca02f16ed8409.tar.gz?commit=d378dce3e9c7384e6c1d1492175ca02f16ed8409"
  version "8.5.0"
  sha256 "47905fda9c6be05e9a3ff1969e998e940280fd4e655927dc35c255003e376c3c"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_tahoe:   "6348903ce3107de7a063e87dfc1e5b18d82a50a18ec5e31be87bd2a526d6a85a"
    sha256 cellar: :any,                 arm64_sequoia: "74256b91c0a0a491b03c0267f70882a4086e895373b40771a6c91eba8b6ee0ce"
    sha256 cellar: :any,                 arm64_sonoma:  "e693e030af60631a938d0534d6f1ac6056db5f7c81b348c997ec1208928571cf"
    sha256 cellar: :any,                 sonoma:        "5b8db8a5ed083b353cff434afa1eebf70551bda0cd4940ffcb90153059b6646a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "83a380808c18a675951b7a7333b3f71e2e785014e569fcc7f98af1249a10d679"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "685a4f3bb3cda8d1841ff870056a4221b7b5b0fe83407d45492c1c1dff9fada1"
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
