# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT72 < AbstractPhpExtension
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

  conflicts_with "gmagick@7.2",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "099347dd12933dd6ff2bce391957df1d00c9a5dc5c8f00a9741416b44561b1cd"
    sha256 cellar: :any,                 arm64_sequoia: "c29f46f732ae74b2f7926bd4772bcafa920484708e11749b0360146277eb9b08"
    sha256 cellar: :any,                 arm64_sonoma:  "dce00b0cb4175ee6127186e2012b1ef1cd24dc9cb61e05ee1f996a85dcb9a7e6"
    sha256 cellar: :any,                 sonoma:        "99745558a717f6300b1f807983dc67d0accb6e1c9a9ae74a3a1ebcc21714f199"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2855d803b2c17b6d675f3b7d0c268c5b2504f995ae26316bd862607c0604e220"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c4bdd3c6e57faf78965246c811769555e5cad8c4a56c33592c8a7e92bd248b52"
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
