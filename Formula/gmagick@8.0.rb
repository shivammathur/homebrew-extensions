# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gmagick Extension
class GmagickAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "61da2c84fecda3ed78e31c24392943dd381b9f60c5c81a98ed0fd4fd05ffd523"
    sha256 cellar: :any,                 arm64_sequoia: "2fda7420d7465e3092fc46a8d4f1d93d857d0cc366247669b4397a9fb22b9944"
    sha256 cellar: :any,                 arm64_sonoma:  "8e3da35181f22975cbef680cf4aff397f00ae5d9b37a39dcba747efc89eb7e8f"
    sha256 cellar: :any,                 sonoma:        "074cc373e50b3a471b716a6050bd3b8ef957d9c6a3f79e077692c3aad31a972d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cc5bc5090384373b51152ec9a8ceace5116aa944570d7fcc9d49cdf50b15dab9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "71596bdbfd11403daef2273c8c7cbc0eb8e08cc90bd5eac34bffcb7bad71adb5"
  end

  conflicts_with "imagick@8.0",
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
