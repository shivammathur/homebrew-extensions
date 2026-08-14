# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT70 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.18.0.tgz"
  sha256 "223d0f77eb5a5e73cf5e7a0652dd8fde7ffdcc843e7f30eeb3998283dec847b9"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "9fb9d6c581768ad73d84df73c4dff7723f58a00b7dbaa6e6a4f14d5d9068dddb"
    sha256 cellar: :any, arm64_sequoia: "767e357c9ec349aaee5315863e8d11ff9067f0d2a6eab50ed2d1967606d3e0e3"
    sha256 cellar: :any, arm64_sonoma:  "7b23fa18d8f7ebf65993434ecec59e316d55c759cf46b6e08f83d440ce11b409"
    sha256 cellar: :any, sonoma:        "39041d8b72582d4dee1546e3b670b0370a6ca76892d8ef292678b85514ebc9dc"
    sha256 cellar: :any, arm64_linux:   "6f8daff192dc3ccb3abb892f7f2235cc2c049bd60d78b99cb8abee3a961cee80"
    sha256 cellar: :any, x86_64_linux:  "a6ffb3df96be8160bf1d2891d7aff6c1da2db8f61f34a17d96a9c754c4606bb4"
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
