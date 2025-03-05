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
    sha256 cellar: :any,                 arm64_sequoia: "b225d3f253abd7b99044c8b44aeee7d86e0047b4f8b94bd619ccce97aafd7519"
    sha256 cellar: :any,                 arm64_sonoma:  "a6b7fc696eb34052c03a8dedb5eef9cd7aead2d10a3ed2efb15fac074cd41b1b"
    sha256 cellar: :any,                 arm64_ventura: "5e11854299dc7f5312993141b761fb4d610fe67df7afb9b6c73d868d81b04b76"
    sha256 cellar: :any,                 ventura:       "953a3317ad9a221a76b8afa4ffd2e21f3c125a18b93f300fcea186c2a69bfddd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b2204b16ce851722ba9f3787208c67acefa055f444b8dc991ab108a901072324"
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
