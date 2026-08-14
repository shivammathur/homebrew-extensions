# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT71 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.21.0.tgz"
  sha256 "97a69edd4f71046b1bd285d914741a60478e69a1db785c2b42aed940ab1fa18f"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "d4cc28e78a2c60693d183a1d9b4ed42aa769b62b4d3fbf5c90ff7e47f581da96"
    sha256 cellar: :any, arm64_sequoia: "7a7c7da2efa786f0185d7c60069f6559cb8a325549ab7e37c5f1654d26c101f4"
    sha256 cellar: :any, arm64_sonoma:  "ac0e2c46d56d5626a8522d01b4c5a674a285ee46a35387d5918e4a2ccec8df8f"
    sha256 cellar: :any, sonoma:        "b2cd5604043cf170a3a7fe7aa66d98826d912ab1a625a6e7d4555ee850d0cbf2"
    sha256 cellar: :any, arm64_linux:   "b425158e495d4669bc85bc3c9e2780d99709842f786b661cd6760eae7a09754d"
    sha256 cellar: :any, x86_64_linux:  "2f3964b6fd5e9b676befaef0f5664b3c2e69d9043f5434a3705f6d6b07e56593"
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
