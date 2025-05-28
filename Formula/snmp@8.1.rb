# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.32.tar.xz"
  sha256 "c582ac682a280bbc69bc2186c21eb7e3313cc73099be61a6bc1d2cd337cbf383"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.1.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "c526ae492f86855f8732dabc516adda01a7930b2fec872bb67f04ea00cf5447e"
    sha256 cellar: :any,                 arm64_sonoma:  "13b85b1b28b3980a488eb397e4045d675649366903c95b2675659a209e3e2d64"
    sha256 cellar: :any,                 arm64_ventura: "6ef0566250a423c5ab29d3899da328a4f7e94598f840402d155f7238319ce486"
    sha256 cellar: :any,                 ventura:       "a0bfcf4b823e1641ac7569a145f27005c9817de01182bd478f54b40d8b64d0d1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bd6b9254a4f11d1b8f42a0fac33b2605ed92aa9815d6baa92c59719ddd170930"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "66af3a4d800f236f1d233301bc29367fb39d4853247c83dafc6bfbdb5cd73109"
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
