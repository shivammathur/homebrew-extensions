# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT81 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.1.tgz"
  sha256 "3a3587c0a524c17d0dad9673a160b90cd776e836838474e173b549ed864352ee"
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "66fb0f98050645e151276ff5d3b6c4f6c6e9a7299475aef0e51a5fddd636f4db"
    sha256 cellar: :any,                 arm64_sequoia: "a01204a72483ef6ce2638c24cf8b0684b81234b66691e04a6b05fb2c7ef29713"
    sha256 cellar: :any,                 arm64_sonoma:  "b01e3b4f0f2eee2038bb56b18a72c058d27761b5ca4c0df3715120e2e3630e87"
    sha256 cellar: :any,                 sonoma:        "2bfbc25f6874fcb4a490e7df29bbab601e44113fc77a9d357d89ddd04320c941"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "84f99b8b10dbffa46151a8f8e950d17bcdbe5044d65d34ec7457ed4634ff075c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "278b772e5c21ad87eb7d14a242e1418855033fe27bff1e841ab6cd55878e6bf1"
  end

  depends_on "imagemagick"
  depends_on "libomp"

  def install
    args = %W[
      --with-imagick=#{Formula["imagemagick"].opt_prefix}
    ]
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
