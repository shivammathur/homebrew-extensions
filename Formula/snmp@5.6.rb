# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/19b4f1903d39f6a8919a73b7d1c0930cd5d89c72.tar.gz"
  version "5.6.40"
  sha256 "f2bd7d6fdb7dee449dd694c3ead14be7ed0a2d0464f39ec55786354a28c81d6a"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sonoma:   "fe544853e3b243b43c66893b1fd39ec93730bcc415ac3ad5a758ab3c74ee3384"
    sha256 cellar: :any,                 arm64_ventura:  "e083da193a240f7dc8ef15a02964420e43ee8902d837160c5065f997d64b86ef"
    sha256 cellar: :any,                 arm64_monterey: "c2995c3887af8a47cd214b2d3331388b74406e85f9761f04d8ffb33c59cf4fb1"
    sha256 cellar: :any,                 ventura:        "739fe065544db2f5bb2f8104b3ea3bf2eb3f35ac33ae52a972de97e21ea8eecf"
    sha256 cellar: :any,                 monterey:       "0e0ca2013a4c5b08d7a58ea3e10bcfafeb8e7cffc311ad1235dd67ecb79417ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6048e2b9d80c842b3c3f325305745785509bd19e8d306ba6860735cefd7ab5f8"
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
