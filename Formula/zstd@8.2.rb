# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "cfeaaccbee9f754e3ee60412ed8ae95652bc8a387e03e5430f53a6e8eb2df4d6"
    sha256 cellar: :any, arm64_sequoia: "b3b5cd579090f133f7dd7a654b82d5c29f56a90d5f8b42d2078d7c2cead59d2e"
    sha256 cellar: :any, arm64_sonoma:  "875d787f9f8b7131c094b429c332db73c7671dceb8bf53052fc2d0d0872c02e3"
    sha256 cellar: :any, sonoma:        "6eef30928aee2be779079d68b5e03c90d82f939c9455cfe75353db46d6f00cab"
    sha256 cellar: :any, arm64_linux:   "f03869abd13c561a4daa603639f8d0768623f37750851f9f97e9e7036937bef1"
    sha256 cellar: :any, x86_64_linux:  "a190b9ae9f5503a23855f28bdb6f9cba754b1aae50be0dc59642508b17fa6350"
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
