# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT74 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.15.2.tgz"
  sha256 "fd8d3fbf7344854feb169cf3f1e6698ed22825d35a3a5229fe320c8053306eaf"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "8d400486a91ec73bdd7f21fe586ad2e565b634d118c788f81869694db0e58494"
    sha256 cellar: :any,                 arm64_sonoma:  "4a91807d0b759c43fbead7525d40632248d8546f58c0de7a028dbf5dec47e582"
    sha256 cellar: :any,                 arm64_ventura: "b4edef9422e24f4d79bd29d3d2655e65c470712709480a5dd20e68ab671ce337"
    sha256 cellar: :any,                 ventura:       "6d4eb88ed1b297853206943485dbec9b5b9b036e8a188859a429946042ab372a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "36bbd79c4ef6a38b71ae8b524f844297742628bba911adb3399ffa21d9472432"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "de08a4014734819e91fe0f5c27a0097d1cb272502af88c92849854b4b15e2b55"
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
