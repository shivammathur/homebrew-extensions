# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT74 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.17.0.tgz"
  sha256 "38cf9e239e72e775bdf01fb5f1abaed76c7ce92e8d3a562a97ef96c9d0446ea0"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "ff7ed693551e6f4eacd8251a262e567a02b9992f9844a59a365b9eb1d028222a"
    sha256 cellar: :any, arm64_sequoia: "07e74487a97a971ca255754ddaa58ad5dfd8463a63523a6babae3bce04437186"
    sha256 cellar: :any, arm64_sonoma:  "d54a0711c04e208bb358ace9ed4ca8162f078dd7bc1318ac038c0361d609451e"
    sha256 cellar: :any, sonoma:        "ee758986af24d554bfa0d2f05ecd9a131e156f92d07bab5ab4d482c1f0455c18"
    sha256 cellar: :any, arm64_linux:   "58e56f6d2edb7d9dacaef61622141e9683ab89708305f833d4ea65283054bacb"
    sha256 cellar: :any, x86_64_linux:  "beb9b09ed0d904c8774c49d59132384a9fbdc65ed2a38e03f9ad436bbfbde8c0"
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
