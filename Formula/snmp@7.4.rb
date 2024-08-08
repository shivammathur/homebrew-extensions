# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/df26731c023adff296c73c9e2b7e3267ef89eaac.tar.gz"
  version "7.4.33"
  sha256 "42b04519172f4e4585fd318183c3ae5f5998dee881147583c9174442e926b356"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_sonoma:   "7ee94f6e4dd2d9eb675dd39f4d0622472061eff4fca495a7c2b45d3a3182d0c8"
    sha256 cellar: :any,                 arm64_ventura:  "cd4f3f32c80b9cf2a2de13779fb033530c887a90454b747b7a3181e5af67c8aa"
    sha256 cellar: :any,                 arm64_monterey: "92f3ed9e3dbe2ab06bb8aaa873125c43fbb8cf9fcbd961efcd0d872d7997eaec"
    sha256 cellar: :any,                 ventura:        "2a20bac88424ca4f4df1330215b2145bdbb8649567d57742df6ad21ecda5a7c0"
    sha256 cellar: :any,                 monterey:       "c69212d413cf68b71102dab18c831ea55ade7ff60d94c5e7424ad33b844ef4b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2c63ec22055ce5696172d245dbce01047a6e68021b1d04826d41db64f20da718"
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
