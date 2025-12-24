# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/383aaa666ea5d825183dde9e676690f62f21ad88.tar.gz"
  version "7.2.34"
  sha256 "3b48ab3d2f57cc29e793846446024f7e1219641647bf1d678a5effe460358d4d"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_tahoe:   "5dbf0582f156c9915cfb0b7c3c0ae8aab6f457cf8c00f761ba5da183afe19c58"
    sha256 cellar: :any,                 arm64_sequoia: "413af230fe7024c3414cfb7141bf26d2d9da80ba1efbe1941df4a227d3a7eae8"
    sha256 cellar: :any,                 arm64_sonoma:  "50d386f3911ee8bcd5995169bb6f199f9ce33a672dbf40bac8f013e8ba54bb2b"
    sha256 cellar: :any,                 sonoma:        "a44a193513ec2c65e7da9e8a3d36e4294ce44435962dc15f1c7f1fd2d7be98fe"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d78dcec0b8236e51e539941d756442da67efe596ce6ddaef1b9e35e3f9cec89b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1509349fea49d5b311f9d7a387493717396017e66ce6a8c0bc3b07213a438a72"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

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
