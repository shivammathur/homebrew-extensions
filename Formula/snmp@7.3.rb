# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/580fe100065f1cd83ac2ad5a6254a1f95dde93ee.tar.gz"
  version "7.3.33"
  sha256 "c3bb3db324daed97e2c50f2755462df5b0cb4b912ab5b38c96dc6cfaca92475e"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sequoia: "4a6555adb8c92097820c123fb7fd90abb7311f94d7ff42a2c7070bc39a9818ac"
    sha256 cellar: :any,                 arm64_sonoma:  "eb22e387744774e1cb3198ed4b9df5d54811bcb2e0262d72d0730f1127670e6b"
    sha256 cellar: :any,                 arm64_ventura: "a8377344352af55e43a13d7fb5a7e115471286f8125c75790ad60636e6f2347e"
    sha256 cellar: :any,                 sonoma:        "e381256ec29be22492652e744d6061d171fc7c9d95f196ca28ac0b65eaf82898"
    sha256 cellar: :any,                 ventura:       "7d542c5d327a1a09c0549409175cb993196e46901b422003a9ae23644b7c3163"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d6259d67964e33b729d3151efbd983ee47ca26c0bf8099757f79da05caf443be"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a46459a8958c0fef56d5d3124f5acf845deb24bca7535d44a64a52493b181160"
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
