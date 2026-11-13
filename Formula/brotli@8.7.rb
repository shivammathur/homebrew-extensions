# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT87 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.21.1.tgz"
  sha256 "33574094e39a433ede3570ba6fcf15d356fc3489abbda396f8cdac472338e1ce"
  revision 2
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "a595214840b0b4e4772a2289f14b505e141a0c43ff4ac658466b2df909bdd9f1"
    sha256 cellar: :any, arm64_tahoe:       "180d50bbf7604ecf54b45851f70b33cad2137ce2339e855438fda8cbfd87d953"
    sha256 cellar: :any, arm64_sequoia:     "1501cd06e4cd6fa6e0eed072434ac09804c06c17d5e789ab9a2d747bb2e70dac"
    sha256 cellar: :any, arm64_linux:       "adc3b827166d4dadcb93716a9ad339e22f5174cf741bc5d6e2436823a94ff3bc"
    sha256 cellar: :any, x86_64_linux:      "a94bec1dd3442c66bf17c856b2906c964d9e00e7bfdbb9285c4b22bd4c74c8ee"
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
