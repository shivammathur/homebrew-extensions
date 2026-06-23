# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT85 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.19.0.tgz"
  sha256 "27d406ba894015352e305c8b557812ffd70b3899b6a519ab874c99e42675cd3a"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "c9fec6c7b78b1392480618af598c6de3c6a888c400529c9073cfdba62895060e"
    sha256 cellar: :any, arm64_sequoia: "b5e7d95708cabab5453aa236edcaccaf58ab58c4d72b2797536c48e6ec992f1e"
    sha256 cellar: :any, arm64_sonoma:  "1feff0315f342f6b8801d7943462deda3dfc00bacd3f887536280b564d3a72d4"
    sha256 cellar: :any, sonoma:        "53a8f395d44c411544bea4ba2c83ce4571e0bd905eb966a93c29ec21a1e99a37"
    sha256 cellar: :any, arm64_linux:   "aaff069bee5ac4357ccb056c676566a38c02fc14ca08122d9fdb668921d63eaf"
    sha256 cellar: :any, x86_64_linux:  "604a4700a9a0b09203ac8d8896aaeb62077d87ad6c4d6bc8a7cd9f5ca9954304"
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
