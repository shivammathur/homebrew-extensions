# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT73 < AbstractPhpExtension
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
    manifest_sha256 "65096d07bdc89ef5f2245fca6d3fad212e064b782ece56c8aaad80fa98bf2026"
    sha256 cellar: :any, arm64_golden_gate: "4b3aa8a4cb2c06a0698c0d93840d66dcd51fb0132552798bbdd8c8030554b3c0"
    sha256 cellar: :any, arm64_tahoe:       "bd3ef25777b79ca49c70bb14af61662a17ca7d4c0c69b56a003f51496c4076de"
    sha256 cellar: :any, arm64_sequoia:     "8840cb30cc740e95f30b4ec6610b81289c3371110fb6411735c09cae6dedc7c4"
    sha256 cellar: :any, arm64_linux:       "42c74858047db5ea6dd0cddb6a14a9da0d796b1a58e186a84e0b60fe6d3c26fd"
    sha256 cellar: :any, x86_64_linux:      "e51417d5437a5be8d89b16d273fe45b8142543efb0ec0b9320e4e550982d70a2"
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
