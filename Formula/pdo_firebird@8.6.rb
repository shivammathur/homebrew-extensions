# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/a2dc4e9ff260cd47f8b8b7abe7b555f2b9ff3b2f.tar.gz?commit=a2dc4e9ff260cd47f8b8b7abe7b555f2b9ff3b2f"
  version "8.6.0"
  sha256 "604d462787c99dfbdba65b701b107c426a1aff6d6d7b140b467d6bbe41e2213a"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 cellar: :any, arm64_tahoe:   "a63374a9609d6e8563793f2394500cd0a07f4f97043fd2ca05747503feb05fae"
    sha256 cellar: :any, arm64_sequoia: "abe96d1787084d8ca5d016bdc08f4d7333ee8d73f6e009b457c39f32ea067e81"
    sha256 cellar: :any, arm64_sonoma:  "3951fd2985622dd073cbd821267e484117e737c7c2e033cac29095e47b8fe489"
    sha256 cellar: :any, sonoma:        "ad1226e0c532af1ca7b0b999d132cd048344015cbc6a3422d0911c2186d168fb"
    sha256 cellar: :any, arm64_linux:   "ce9cf8c6b42ff7d3b4660bc1184652fe89cb073a9772ad77a08dac36a2a52c63"
    sha256 cellar: :any, x86_64_linux:  "e98053c68ec3df807aedd298594097b3756601afa03b7f686c309ab8b13a8e9b"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
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
