# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT84 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "5e596e2bc0f5abf99345f242e0d71e39c51c4421620d65b8a6e930187e3b9a90"
    sha256 cellar: :any, arm64_tahoe:       "0d69a0e4ff880bcfbbaab81861a1a2d4499cbc188f1515386fdd29fe73a4d54a"
    sha256 cellar: :any, arm64_sequoia:     "1846eb2b17fa867ebd9e8de1f94b4146f3a387f0a0ad731429bf2ea4214122fa"
    sha256 cellar: :any, arm64_linux:       "60bca3859cdbffb8aeb7a0b1f8725981e8fa3b80e0136871c7da626849cb2b5c"
    sha256 cellar: :any, x86_64_linux:      "47125ba77cabd521fcfb0310a0b594d561d7b2bd5f3ba23b49bdab740afe9744"
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
