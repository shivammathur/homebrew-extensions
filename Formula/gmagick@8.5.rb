# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gmagick Extension
class GmagickAT85 < AbstractPhpExtension
  init
  desc "Gmagick PHP extension"
  homepage "https://github.com/vitoc/gmagick"
  url "https://pecl.php.net/get/gmagick-2.0.6RC1.tgz"
  sha256 "350cb71a4fbd58e037c7182cafa14e6f6df952126869205918fcc9ec5798e2fa"
  head "https://github.com/vitoc/gmagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gmagick/allreleases.xml"
    regex(/<v>(\d+\.\d+(?:\.\d+)?(?:RC\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "d99ff43ba1900a4e9aa50ca0a328ac7f4666918e399c811897fc74feb4f816d5"
    sha256 cellar: :any,                 arm64_sequoia: "09d5ab0ac282a21fff9a92077da8a9c45b2e05c7e5b1dc7147312e8e9176d632"
    sha256 cellar: :any,                 arm64_sonoma:  "1fc1f5f5cf9062fe243c0767ad9b5bc059d674a69b568e8aa67110216b4f7431"
    sha256 cellar: :any,                 sonoma:        "16f03ac382ff5f33485a27d0a8a8f72e25e1377d998132d72cde73f2e7871479"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "73728a106298be75b94a414685e59adf4e097ce65045a661811d77ac53f74e93"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "286d85c77bf1ce544589b3d8a45d9aebaf989c2d83f16279232b920f518383fe"
  end

  conflicts_with "imagick@8.5",
because: "both provide PHP image processing extensions and should not be loaded together"

  depends_on "graphicsmagick"

  def install
    args = %W[
      --with-gmagick=#{Formula["graphicsmagick"].opt_prefix}
    ]
    Dir.chdir "gmagick-#{version}"
    inreplace "gmagick.c", "zend_exception_get_default()", "zend_ce_exception"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
