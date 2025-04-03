# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/f4954df0c93a3a817fa7e2f4609683ba2465e371.tar.gz?commit=f4954df0c93a3a817fa7e2f4609683ba2465e371"
  version "8.5.0"
  sha256 "33b0fbb68f431b59ee8aaf98d166b24ee656d1ae87e1904cbcc991688561a8c0"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 18
    sha256 cellar: :any,                 arm64_sequoia: "a0ea92efcf2a86ff0de3a67b3e41955ce48af006103377e54fd79ed0d1196914"
    sha256 cellar: :any,                 arm64_sonoma:  "3c96f17ebb28c58ac510730ad710691c8d1d567a7d91a06e06f89ebea495ca80"
    sha256 cellar: :any,                 arm64_ventura: "a1fbc88da955ca429ca716c59c78a9fcdbd7cbb4e1c08a397fb10a8dd9262948"
    sha256 cellar: :any,                 ventura:       "149856cb7fdae0be8a830632ba05127105135e91b23d559b7021ddecccce8b7b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0af11f1810be7841f13065d81929f261573d800a00a45497511e938afdd2d542"
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
