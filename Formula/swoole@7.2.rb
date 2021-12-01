# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.3.tar.gz"
  sha256 "aefea9b6e5dcb61fdf0462dc8a1b63deef4a1c73fdeff754eef81ab45f231230"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "6f60d7386792732e77d4ad6348cbbeab36d8d3fa70486759ac6f927422094c4d"
    sha256 cellar: :any,                 big_sur:       "6b3c90b914456d27dc7fe8ecce5b498f1c9d40cd2132181bccf4fc3ed9e2966c"
    sha256 cellar: :any,                 catalina:      "668cea13bf1a97d6f95996cda587982671513523cf2ca0a505f3f0c69079cf2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f60d9f047b2bf8a583b3c8d5bca17ab7844529350ce593203903a4425e818503"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
