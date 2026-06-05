# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT71 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.16.0.tgz"
  sha256 "3d5bfdd1c70b0e3e892461fca3bc74e899322c69404b706fec27af8118d9bf99"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "417473b8cad935469d334d8104ab7b0eb57312b0bb35589468d6b4c55a52eaa2"
    sha256 cellar: :any, arm64_sequoia: "ab106d32d4b3761635fb0f0a6ba0b915da6481412762d892ebaa6a13dee9661a"
    sha256 cellar: :any, arm64_sonoma:  "081775a513a5422953d5ecb9eca4ee8d59d2d3220d0b1e71763c564f0ac4e440"
    sha256 cellar: :any, sonoma:        "3b0f37653ce0b9436a05bf2f41bd4df358eb01fa3643f70b8949c04e50cacf2e"
    sha256 cellar: :any, arm64_linux:   "f8e1934a52e72325c8b81923a25ed4e7fc333f8080b37e689e0100e0376b0303"
    sha256 cellar: :any, x86_64_linux:  "5932f1d40061dd844b6a94f0005209bde12ce7ed680b3cdf7d34d281976f82a2"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
