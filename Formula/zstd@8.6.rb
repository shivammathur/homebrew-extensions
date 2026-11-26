# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT86 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.19.1.tgz"
  sha256 "b280d9e9c146586648b0d4c14720220b9e1aaa1a3083a31ab1665784c90601d0"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "f37b961eeb01f8795d5e4eb2545b6ed33ea57a0cd2291ee6de9de6270e9f1242"
    sha256 cellar: :any, arm64_golden_gate: "c7a49d63d0f2c49966660534f95ecf6df241e1e203303dfae8c47a961270de64"
    sha256 cellar: :any, arm64_tahoe:       "34eee1278012ff62396015fd2af4220d9576a881311372f5d56fa56cad07395b"
    sha256 cellar: :any, arm64_sequoia:     "0a03587aed5aa1ee57cb1edcb21623398a13cde0e10f1c850a77628f497c0ad1"
    sha256 cellar: :any, arm64_linux:       "bf5a84ee549b35930adf97fd24ef8a98bff09191e414ffd172c9c03c4c77371e"
    sha256 cellar: :any, x86_64_linux:      "986ff4f3eef3ff687fede474fde7aeef55c4309f017c355ce2bf7ceddd28fbec"
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
