# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT86 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.18.0.tgz"
  sha256 "223d0f77eb5a5e73cf5e7a0652dd8fde7ffdcc843e7f30eeb3998283dec847b9"
  revision 2
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "b9fdcefa3d9ab55ce77593a0bc6e943d016445520cd73eb32fab9d75e09815a0"
    sha256 cellar: :any, arm64_tahoe:       "5ee6f5c437d5944d3c5ec66b239ff264f8b3a5076d7af703923c2ad61416d8e4"
    sha256 cellar: :any, arm64_sequoia:     "8b953beba9b735d0b32626c14a28a2bf3cdb6fc67130305f7f76f5fd032494ed"
    sha256 cellar: :any, arm64_linux:       "7ba8c7f836fc8374f1f1ee1a48be3a83da35207f274f4c9ca3d57b1fc8871a7b"
    sha256 cellar: :any, x86_64_linux:      "fdc6ca71bb15e3faf665ee7e6fcf91939ebbe042079102f0b6efd1ed28353948"
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
