# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gmagick Extension
class GmagickAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "fa865011cf94b2957381909998704268d89e24496a4fc3960af800991d469550"
    sha256 cellar: :any,                 arm64_sequoia: "9cc19d8473becda426d34e353fbd2182f21149ec55ed97435d9307d2b47be7dc"
    sha256 cellar: :any,                 arm64_sonoma:  "ddcca82dec388371a0dc1f06c93a19f13cadf97557602b3433b81a843e49d0d5"
    sha256 cellar: :any,                 sonoma:        "9e70c81afcde46b2d5dc8faaa722c3e43bfab34c97bae47838c8586efc1d9c07"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fe3af1ca55e0dbb1389d3135c7f16bbe0e903a16bc9d87a84094a6a81a2184e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "18abb270b95bcbd504465a67d1589126bb78733332d46abf7f453acd735e0ec3"
  end

  conflicts_with "imagick@7.2",
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
