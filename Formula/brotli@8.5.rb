# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "8e417bdde54c71225428d1243d5ac5a4f7e15988d251d8501da360e7a525b6a9"
    sha256 cellar: :any, arm64_tahoe:       "c138eec2dc2dd9f642e42e32c095eec6654ad9bac4f7c345b121614d3f68bf20"
    sha256 cellar: :any, arm64_sequoia:     "97eb6e362a250a504ccfab04401ff2d18f2437af9f6d6ca6f393b9c496934ab3"
    sha256 cellar: :any, arm64_linux:       "946b1033e60909997fd3fbe672f7f141b392aa538f146ec2597b021e8e68a7c8"
    sha256 cellar: :any, x86_64_linux:      "518f53ae26112ed7d7f10c2541cddebc79611f8b72187c247aac7ceadb8fbdd2"
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
