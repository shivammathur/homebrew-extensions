# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gmagick Extension
class GmagickAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "4de1f88e72707d85adb55dd172db50cbf682016200f27459eac1b4178b36716a"
    sha256 cellar: :any,                 arm64_sequoia: "3f1de67e2f272227978bdfa4e4542ff2fa024473fbbd62deba8bade0e3ce7993"
    sha256 cellar: :any,                 arm64_sonoma:  "de5a1804bf7f4b96226aa59d0e1b5d1c147412d2263dea7e1aeca4b800d802ea"
    sha256 cellar: :any,                 sonoma:        "7916f923645fa607a1fc65f17518a4c3028f48116ec4cdc453bc5ff9b96b6ee9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "57f72589c125796dfde1f84f97e8667f59957d4e1dc245a8b45fd51e8728f3c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7aeea20f6e6d90001402ac4ad46f1f5b131fab6ef3db3748662492ae09467454"
  end

  conflicts_with "imagick@8.2",
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
