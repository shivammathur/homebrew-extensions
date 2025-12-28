# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gmagick Extension
class GmagickAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "93bdadf36f6ab5283b7c81c00b905c557e7df18a07758f898bf15825272b07a0"
    sha256 cellar: :any,                 arm64_sequoia: "3091df2525acdfe8429528cdabc5340f84620274a1cd2320b09cba831219e210"
    sha256 cellar: :any,                 arm64_sonoma:  "71e634671acd8f2cdc6f8f251879ce315919a523a3fba8df4edd5984311dca69"
    sha256 cellar: :any,                 sonoma:        "37dec1dfc22e4d32a6b6f043f0c4151d0614dc024aad0d80b6f9a4552345ba99"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "45b98221a60e1bd31d8346aefe16fcfcfcc5eefbc9e57949eaae76d6682c2bab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ecc19f5cedb5af59c0d935daa2ba74cddefe2fc85c6a466f328b0bba316c8de7"
  end

  conflicts_with "imagick@7.4",
because: "both provide PHP image processing extensions and should not be loaded together"

  depends_on "graphicsmagick"

  def install
    args = %W[
      --with-gmagick=#{Formula["graphicsmagick"].opt_prefix}
    ]
    Dir.chdir "gmagick-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
