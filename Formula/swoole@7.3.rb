# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.10.tar.gz"
  sha256 "0bf908cee05b0aafec9fbbd3bf4077f1eeac334756f866c77058eb1bfca66fd7"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "eb324cffdeeba52ff72a68c334bc1519e3e49c5b8eaa47b10b4fc10bb296102c"
    sha256 cellar: :any,                 arm64_big_sur:  "d54979d7ab48fc8463ff4592aaca5f845e283c780a5057e1775b14d3a5602606"
    sha256 cellar: :any,                 monterey:       "d976506a30bf68ae2b51951c9a960183eee974037b0895f3c07966be781f99b2"
    sha256 cellar: :any,                 big_sur:        "95fd628df8f5f7e22e70bd4b7429b89b61b91342e2ae82c379c9c2fd4b0a2833"
    sha256 cellar: :any,                 catalina:       "593acf19eb801a5fb96b3e93ef3b18076d35d7e35a046ba7e1a08271d076aa45"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "26906f94d834c0d22938b63867223bc6de18d4519ddf263a1aadd08a3e365811"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    inreplace "config.m4", "PHP_ADD_LIBRARY(atomic", ": #"
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
