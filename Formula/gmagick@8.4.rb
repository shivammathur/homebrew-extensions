# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gmagick Extension
class GmagickAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "c4cad5116419c07e473271cd42479596334a6f7476c28c16d0710d10d38b20d9"
    sha256 cellar: :any,                 arm64_sequoia: "a8edcbfcb7ddead6dd0207628b7b3535fe593a9be864778617a9380300518f66"
    sha256 cellar: :any,                 arm64_sonoma:  "d08c77a74e6b9f155ca5905cdaf078f13efa823351014ead32fa44228764b5be"
    sha256 cellar: :any,                 sonoma:        "7539f12175d48fd999875e0d4c94e34364e4b23e9543be0474fc9395581b2266"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1b8c2cf5a08d5509186412efd3c8aef2bb3b058a204e88ee2c605966133c2264"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9665d3638b8ef96814eb6ac32cb951a9b10b530ebe7ed3c974e7af9021a5bde9"
  end

  conflicts_with "imagick@8.4",
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
