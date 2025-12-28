# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gmagick Extension
class GmagickAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "ad680265ec3762e0c7c6c4665dbffc8fa0f41fcdb3c4b712944ad412fb57b790"
    sha256 cellar: :any,                 arm64_sequoia: "bc31fe151920734300f8e169feaf338dec3d48351001aca26e4c734956252b16"
    sha256 cellar: :any,                 arm64_sonoma:  "552ae2d5163d2eaec45f5b2415422eaeb2d4084831a86fd5b013310b41c7a16c"
    sha256 cellar: :any,                 sonoma:        "c67af28416568fc6cddd3b44ceea36ae8f94273d33783990cbad9c04191aa042"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e2916a69af80fe0a8bdfc56da26b7f4dfad9a116f4b864d22e8771fd84816146"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ae0b6a2b8d48b09ef948b42a1e8873b757645b91564003e849cd8353c514403f"
  end

  conflicts_with "imagick@7.1",
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
