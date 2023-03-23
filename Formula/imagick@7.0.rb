# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT70 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "ee2b022d74ed41aa0a220c2f248bca640e2af2a2b572c8219040ea152a46a442"
    sha256 cellar: :any,                 arm64_big_sur:  "1072b190c6b3d709dcb8b3b65b638c81efba3087a93b8056e3e1e433af87a6a8"
    sha256 cellar: :any,                 monterey:       "8a5071c9445feec1a309a5f4e61be5042c47fbd7c36141f8240314fb2260b325"
    sha256 cellar: :any,                 big_sur:        "69ded67d9a22856fd4abc78f66857d0627b57bf1b9fc3ffc4dece861ac866130"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1f294422452054dbaaa6d1eec0cee76a43e45c11ae50a730bafeeb0561273f3f"
  end

  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
