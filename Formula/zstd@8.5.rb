# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT85 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.15.0.tgz"
  sha256 "cd8bb6276f5bf44c4de759806c7c1c3ce5e1d51e2307e6a72bf8d26f84e89a51"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "d31ea7c486e87f35c7a94c09669f68fd71dea6ae8d429968f722d2052d650890"
    sha256 cellar: :any,                 arm64_sonoma:  "251084aa5f9339776cfe8da7b34d4839e880a27669754ec7a43df1c6f178c84f"
    sha256 cellar: :any,                 arm64_ventura: "02ed9f27fedf7b301605c8c660343b09829db3d1ae6ede928a0a706e8aa4f87f"
    sha256 cellar: :any,                 ventura:       "a7882c382de73d88fa3268f40ae7e2812528423adaa283b786e44c13c3b4d419"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5fc5ff926fba0393191e9c5d520f1356e4c6fb5521956532aa03f642beccb6af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a2d405dc8d00eea6c0729635b050d954433270e180346d519d5ea0cb74ce2943"
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
