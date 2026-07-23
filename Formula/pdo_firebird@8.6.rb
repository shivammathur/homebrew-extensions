# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/28dab5fafb18ef3757cd56639c3238c8ac8b1f9f.tar.gz?commit=28dab5fafb18ef3757cd56639c3238c8ac8b1f9f"
  version "8.6.0"
  sha256 "75a8d350649c19bd708e2582ffbfc2a6bcd845c2fbe89e7953aaf37e5bed4bcb"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any, arm64_tahoe:   "c3c6b38de47a5c24f6f0cfaac4cedab35e746b64e6326d4da19e4c19c6d719d4"
    sha256 cellar: :any, arm64_sequoia: "b44d463d7d42766b56297fbe3d20ef4b1518d460540b67029eff1dbe176fc24e"
    sha256 cellar: :any, arm64_sonoma:  "0f6c38c94f53940b0ab1853c409eb23ba0ebf4bc3c11d9b9e1c56e080b46460b"
    sha256 cellar: :any, sonoma:        "00f1a1c0446b52dc90a3f5f6c9608c6b65837d90f27423acf5e55a7af8b19235"
    sha256 cellar: :any, arm64_linux:   "f1cd4958bb0a5744c87f3217b5d39ef792ec6547d5a81beb484ddea51b689464"
    sha256 cellar: :any, x86_64_linux:  "0c7553e2995af5c8a952c8f99c41d5c49e4f4f49faa6fed4f4b311bf1b4597f9"
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
