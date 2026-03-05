# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_tahoe:   "682f8a14c67c9a0dc78d253ec8e156bb78a29023f4a419f2a1543aad03181ee1"
    sha256 cellar: :any,                 arm64_sequoia: "7c79bd44836305e655d9edb1d78a3b17b8349ac6b0dc936b07a6ca89eabfd1d9"
    sha256 cellar: :any,                 arm64_sonoma:  "244d6d6143dd56f5cb9f24a38d176357f943a353c1b300014e57ec74ac4eb0cb"
    sha256 cellar: :any,                 sonoma:        "d72207daa27b28ea870e8e6592786250df4509fbfc4ed479b2f93d05a1254133"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3b96d222191514f668f82c42b1bc743b6dbcb8d427979b8ba0e8c5269390cbd8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b855f56318a32d6ecf8e16bcd164f282fb861105d441eef09ed1eae6c0bf1645"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/11a95749b1c10ef9ef2ff19a2f27739673ca9883.tar.gz?commit=11a95749b1c10ef9ef2ff19a2f27739673ca9883"
  version "8.6.0"
  sha256 "58b132b37a12089a981102d1717b2f9afc594e13f35e6d646adb2e57692737bd"
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
