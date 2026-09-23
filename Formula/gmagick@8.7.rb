# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gmagick Extension
class GmagickAT87 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "99ce8f5211b8112522510df228424ec1f776bf56bc24857f55818eb42af89ce7"
    sha256 cellar: :any, arm64_tahoe:       "0d04e859fda5443bf4e5356f2561c60e476bb57944e89f893c7429c3eb3d6bb1"
    sha256 cellar: :any, arm64_sequoia:     "89a1a083cb9b5f785812d9fb8901fec466b69aa222a8e717c31a343f3096668d"
    sha256 cellar: :any, arm64_linux:       "bf423b1d9b49ac1053c11d83562d039845253a57009bf0fef104be0d41c7f14a"
    sha256 cellar: :any, x86_64_linux:      "163221f6b3f5c43d46b0aa5934d7199cd2fcb8fe6c569c6feb112793f84f6ba7"
  end

  conflicts_with "imagick@8.7",
because: "both provide PHP image processing extensions and should not be loaded together"

  depends_on "freetype"
  depends_on "graphicsmagick"
  depends_on "libtool"
  depends_on "little-cms2"

  def install
    args = %W[
      --with-gmagick=#{Utils::Path.formula_opt_prefix("graphicsmagick")}
    ]
    Dir.chdir "gmagick-#{version}"
    inreplace %w[gmagick.c php_gmagick_macros.h], "XtOffsetOf", "offsetof"
    safe_phpize
    inreplace "gmagick.c", "zend_exception_get_default()", "zend_ce_exception"
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
