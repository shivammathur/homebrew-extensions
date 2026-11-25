# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT71 < AbstractPhpExtension
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
    manifest_sha256 "593c9946f6e3b689774dd1df77d8950e70b626fbbffa431123fb6100a1195cad"
    sha256 cellar: :any, arm64_golden_gate: "f5cea58c98ec197d2608a960a7707a5b8129d34069cc45b6167b1fb423d23230"
    sha256 cellar: :any, arm64_tahoe:       "a56eadb1f8c233e49d4637b37f97151f71ef2f9813a2f3ac89f37e01fd9911e2"
    sha256 cellar: :any, arm64_sequoia:     "4cfb501e6b0b314d3c1dd848ce37046729ba4e71779d83f517db7387f4b8c36d"
    sha256 cellar: :any, arm64_linux:       "286151490db1c2650eaf1f61e315dea8ab7b8be8019d8433430c47557dc04327"
    sha256 cellar: :any, x86_64_linux:      "bdcbc911460d34071a36cdfb13833b98799003696653bed2457c374ceeefef04"
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
