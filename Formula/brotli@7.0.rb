# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT70 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.21.1.tgz"
  sha256 "33574094e39a433ede3570ba6fcf15d356fc3489abbda396f8cdac472338e1ce"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "28784fb5afa7436e3238ecca00abab1fbe7d13f68e63e1f322ad6b07d6139ff1"
    sha256 cellar: :any, arm64_tahoe:       "9b407620383b3c93074e9c16350a5e69a4ab2ffba57488d6acbc4c407c41ae73"
    sha256 cellar: :any, arm64_sequoia:     "9432b5c0fa44638e21de49f21ee1fc0439aea406be758990096bcb63f1164f7b"
    sha256 cellar: :any, arm64_linux:       "d99e1b4c6aa05873b2d48309b4b182b57d7be5ec24adc4cdaa542af3d1571382"
    sha256 cellar: :any, x86_64_linux:      "cf4e38318eba857963a9b0f19d6a887bff99dc89154700662654e49f51fa36d4"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Utils::Path.formula_opt_prefix("brotli")}
    ]
    Dir.chdir "brotli-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
