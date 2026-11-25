# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT87 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.19.0.tgz"
  sha256 "46592a6576c2f42927659dd00dc6c3f39f1fcae7374e95e1f4e11f8ce4f477fc"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "26d90d958a17a8adb18a654e34488d9dd990782e8bcd8560d8a630162c2b9363"
    sha256 cellar: :any, arm64_golden_gate: "f6870fffd89ca689a3c5c2b3c39ea8bdd1f1eb98eb2b29435dd1325edd8ad3f4"
    sha256 cellar: :any, arm64_tahoe:       "755287cee633a9353c40fd6b691e6dafe1e739d00f2a55466cb37d88520a3eb9"
    sha256 cellar: :any, arm64_sequoia:     "442b1f6a89450f2ed5751f7d3a135d2807438ad6befbb857114df7ab464c7a82"
    sha256 cellar: :any, arm64_linux:       "b6e59da33182b2cfbafab928e36572e87397698c667117ea34ff98c097297c17"
    sha256 cellar: :any, x86_64_linux:      "edcd3fcdccf64e08a3a37d0a2a9b3ebb58cc7646849065cee89919bac800810c"
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
