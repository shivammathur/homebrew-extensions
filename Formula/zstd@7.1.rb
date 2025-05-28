# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT71 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.14.0.tgz"
  sha256 "207a87de60e3a9eb7993d2fc1a2ce88f854330ef29d210f552a60eb4cf3db79c"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "ac390e9d70615c647d27fcd1d8db86a3c7b487af2b1312150c2eae0b08deb1a0"
    sha256 cellar: :any,                 arm64_sonoma:  "d0149e82e19f0e751aaf9ce28d52c17c43214d89386bfe992416391350370cbf"
    sha256 cellar: :any,                 arm64_ventura: "8211deb3a8d42977a4a35a4c8886bd9f6dd1cb20b925bffefc360016b367c345"
    sha256 cellar: :any,                 ventura:       "1b4af0811d3a76a62ba6db3fb5e09869d8ed5f24c8df8a057b4777d93489d179"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e3a38d43ac88b5c749554df06f67e61d904db6f5238c1e150d6bb1ddf7c47c46"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "21c2c1406ba1708d5d58f248cf91fe22a0098ee6e37bc1c490572fc3ac4562af"
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
