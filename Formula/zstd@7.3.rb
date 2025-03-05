# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "8748bee7ac5438f938114c85b954cc58cfa08dfc5ebb36847461f765efbaa29a"
    sha256 cellar: :any,                 arm64_sonoma:  "5cae76c62bda1456598bdebd05ce2c654c8d9ca08f22b7c2425f71216b929f6a"
    sha256 cellar: :any,                 arm64_ventura: "0d14f9c62a6c32be50e899845e45a984ed2747b3f002114752a198fe61d87d42"
    sha256 cellar: :any,                 ventura:       "870a7c452afa732f34391cba58ab2c542f373907a10b0af459e40b69d6989d48"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e448bf61720f6f816d25426b5c18437561ac517c0dd7a8ab744393716b073afa"
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
