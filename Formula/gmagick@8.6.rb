# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gmagick Extension
class GmagickAT86 < AbstractPhpExtension
  init
  desc "Gmagick PHP extension"
  homepage "https://github.com/vitoc/gmagick"
  url "https://pecl.php.net/get/gmagick-2.0.6RC1.tgz"
  sha256 "350cb71a4fbd58e037c7182cafa14e6f6df952126869205918fcc9ec5798e2fa"
  revision 1
  head "https://github.com/vitoc/gmagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gmagick/allreleases.xml"
    regex(/<v>(\d+\.\d+(?:\.\d+)?(?:RC\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "a7a3d56bdaa1c1f6fd142e3a813dbe84b9afe702b8a378388815d22abac52b6c"
    sha256 cellar: :any,                 arm64_sequoia: "a1a0ded2231f6f8b6ca398a48eb93fc814222e262a9c3f7b2bdf6045bcc162e9"
    sha256 cellar: :any,                 arm64_sonoma:  "ff7a83fd0e4ea6381eae002f742f6d8793851f9c50623e6661b03ba6592a19e3"
    sha256 cellar: :any,                 sonoma:        "b64aa842b78cd5468a3db44504d455184937b41135b73c57e78bb1e84803410a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cb2a49cdc37db333285ab26828dfd03a7135b62163a317ee0569db3e427b67b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b7233d91bdfda6ea993a22dcf6a7c81ad699c638ae0e6743a5bef8997feacb2e"
  end

  conflicts_with "imagick@8.6",
because: "both provide PHP image processing extensions and should not be loaded together"

  depends_on "freetype"
  depends_on "graphicsmagick"
  depends_on "libtool"
  depends_on "little-cms2"

  def install
    args = %W[
      --with-gmagick=#{Formula["graphicsmagick"].opt_prefix}
    ]
    Dir.chdir "gmagick-#{version}"
    safe_phpize
    inreplace "gmagick.c", "zend_exception_get_default()", "zend_ce_exception"
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
