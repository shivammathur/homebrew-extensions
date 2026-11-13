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
  revision 2
  head "https://github.com/vitoc/gmagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gmagick/allreleases.xml"
    regex(/<v>(\d+\.\d+(?:\.\d+)?(?:RC\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "97abadb42b6e72cb1435a5041b73c38f22404441ec7b35e626b00692744861e3"
    sha256 cellar: :any, arm64_tahoe:       "9ca0d6c76c9c063b8628ce3b6cc54eb9c8e46ba5a42f64c1db43272128f4e207"
    sha256 cellar: :any, arm64_sequoia:     "5f9510fddb42f09f71fed1b2ee0a8718e02e29e880239a718fe1533f2618af0c"
    sha256 cellar: :any, arm64_linux:       "f004b00ca5346891562cb63193271259eff88364782e94e7b789101026aa6d13"
    sha256 cellar: :any, x86_64_linux:      "1705ede24e7b0a991e16f6ab7b4d2f59f4b1ee449aae1e149999ef1da74dfcee"
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
