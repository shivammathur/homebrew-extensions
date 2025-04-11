# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT71 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia:  "8735de49035e2c846908e1a5be7bd6ae25724860fc2368f82ff4492616e49fb9"
    sha256 cellar: :any,                 arm64_ventura:  "46c70ff717edaed3b1eea7918e62b9921bf416407dc2462a225fe40b8587ddd1"
    sha256 cellar: :any,                 arm64_monterey: "a834f937931475b5418743927fcfef51a48321c580c6c3b67dc76b85736a6d87"
    sha256 cellar: :any,                 arm64_big_sur:  "f971553edf8688c557d8ccca1ef9632679097bbd36976baee92100eac1bdeff5"
    sha256 cellar: :any,                 ventura:        "48e188a0c463d469560ab6fec55bb7da07ffffff6c16e50fc60ef9139ebc0b65"
    sha256 cellar: :any,                 monterey:       "7457a4220659e3ef603c09ad530db75dbc84ad668f01e64d7ab0919aa0ab80a8"
    sha256 cellar: :any,                 big_sur:        "e4212426eb379069a80865dc1df696bcc8bccbf44af5e82358394ddc24d6d752"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0b71dc93d101cd12829eeb10e8b2fc15b2683cf49464258bbb12f3dd9e5b9660"
  end

  depends_on "imagemagick"

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
