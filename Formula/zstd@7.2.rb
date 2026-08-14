# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT72 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "e2373130ebe4b73f21fc6ec4b05f66e3585ae0638cdc918e2d37075ffc234370"
    sha256 cellar: :any, arm64_sequoia: "7149f50953bd3c6ddabb5d4d3d39392b398cdfc9d9efbf57e08726ca6d4e543f"
    sha256 cellar: :any, arm64_sonoma:  "c14907b3ffeecb8072c1b89f20236241da1adb612ae79c4725d3f01a9dda905c"
    sha256 cellar: :any, sonoma:        "8228e74faca5b645ef95d1e093a229ec69e39e61817608e6bf92c582f700ffe6"
    sha256 cellar: :any, arm64_linux:   "67f3b053668d18bd53fbb550d4a74f3c5ee45b1ec8b2f2c50d671ab99fdc224e"
    sha256 cellar: :any, x86_64_linux:  "393f5c149564bdb8d10a0a3f3624b1d9bce479ca4c9b7c0c64938eabb4c8658d"
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
