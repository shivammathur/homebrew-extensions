# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT84 < AbstractPhpExtension
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
    manifest_sha256 "bd72f1978c4d44fc71646e633fb951315dc0b046f8b114fc216eefb8d6ed73e5"
    sha256 cellar: :any, arm64_golden_gate: "c821a63f342a28ce65bf51d3faf9ba9c20a634528391006b82303fcc2b5fcfcb"
    sha256 cellar: :any, arm64_tahoe:       "b8889b81247da0cc7b82e0ea2480f3c5c622b498a9bf520bf3ad0f0b00e010dc"
    sha256 cellar: :any, arm64_sequoia:     "2618545ecf2324900a56ececca2ff219490efcc39a872cec4d71c4d5b2676bfb"
    sha256 cellar: :any, arm64_linux:       "7e8c8eb3c21eb55cedeb9f500f3af347231a2a4d73a1126cee76bd29417f4a77"
    sha256 cellar: :any, x86_64_linux:      "1ad0dfa3c4d15c28a9c26211a091e7fa55b70f63a368d768a6c07381ac1dff59"
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
