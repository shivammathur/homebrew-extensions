# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/87499e44f29137847b95aa5cd1a130d1c3c5b276.tar.gz?commit=87499e44f29137847b95aa5cd1a130d1c3c5b276"
  version "8.5.0"
  sha256 "88e9f47361647bed6a6135409165e3a8d9347ecbe4b4f8d9842b9d379845bf8f"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 20
    sha256 cellar: :any,                 arm64_sequoia: "7b0d99afc4a97f0bfab0965cef8c480add95124a03451e43b952190c24f82997"
    sha256 cellar: :any,                 arm64_sonoma:  "f865dfdad2efec23d99f2de36e5313524b5d55d665d910f7e865a601099781b9"
    sha256 cellar: :any,                 arm64_ventura: "4076de6ec802fd1027932c8573124f545dabe1f99d89bc1d161e5bb0892a7ab8"
    sha256 cellar: :any,                 ventura:       "97179b10d4bdc0e83f4a08b5d22bd56d97d784443e08179af530732115779609"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e52c7479e22cfd65a1ce04c8d5c050f114d1a03e50ab7bc3e92d4bdb4deed754"
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
