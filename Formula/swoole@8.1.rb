# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.7.tar.gz"
  sha256 "2083f7b5f8715ab1074b8640255f503ab91d77c6633c53421e381d8ae3bcb67e"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "4bde7bf3ad600f9596498bebba02525f7f07ea935d14821b621793e6d455ef58"
    sha256 cellar: :any,                 big_sur:       "17ef6b9cee4b8547d51767f7e344d3698f56db4adc055e79799134c3730eb86a"
    sha256 cellar: :any,                 catalina:      "4f43d3badbef199661259e44832d911cb9fb690bcc16c0f40798d00270c1a6cd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1e7c67460940183357730d6436d54eb188ee2598bb17f5eaa1918d164682faac"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
