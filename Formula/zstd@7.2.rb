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
    sha256 cellar: :any, arm64_tahoe:   "89f4c117ff078b72422fdedf5420dd1e8776753a0316bc40c9242267ba03069f"
    sha256 cellar: :any, arm64_sequoia: "bc8f4990b769ec47d21554ef19b57e98892b88b0dee4a2d71bb65ab0dcbbf078"
    sha256 cellar: :any, arm64_sonoma:  "0f25df0092c639b32d4cea0a6bcf5969e359ae03ca95eefad015ea69011fc7ff"
    sha256 cellar: :any, sonoma:        "cc9eebbab55115ed478f779e80e4b3e35d69df727ae6c16c4ece05ad0d3dd1fa"
    sha256 cellar: :any, arm64_linux:   "f82ff0223f1e5f942c4814593cbc159a6782e8cfe75678f59130dd989f103de0"
    sha256 cellar: :any, x86_64_linux:  "5496c3164daf2ff431562a1310e54241a575296b87b4e64a8c766aeec330648f"
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
