# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_tahoe:   "b177c6f7e2986d3696bfa9ed09244aa9ce4680bf3223a14ac57ca04b1c39e279"
    sha256 cellar: :any,                 arm64_sequoia: "84f61bca32cb7c5e68603f9ddb54bc6f2330326e37b65d202866ce012fd756fb"
    sha256 cellar: :any,                 arm64_sonoma:  "578c2c2dfb23ca153aaf09b03ae089d14bf77a5c701b89ace14f117bcee9426f"
    sha256 cellar: :any,                 sonoma:        "6364349164fc7f7eaebf8e53a4803b8ac226897d80e9ea890c24a13a81cd08b2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4116b6d37a5b5b38b1865120b525399245d969b98eba28db67b6472c79cf8ff5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "be71f538dfb499d611004531170f0c2b49761f81799b8b8a82c1d4c2f23a6fa4"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/0f3e741b538eefb1d1ffa42dc7b13d6ecf6db660.tar.gz?commit=0f3e741b538eefb1d1ffa42dc7b13d6ecf6db660"
  version "8.6.0"
  sha256 "330d67659f99977b5008d74c00eb52f535f374a95d587db0ae283716506054e3"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"
  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
