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
  revision 2
  head "https://github.com/vitoc/gmagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gmagick/allreleases.xml"
    regex(/<v>(\d+\.\d+(?:\.\d+)?(?:RC\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "819af6a90cdacbfa66096603d711bf0051c3249e258285f165b0aa8e6ac0e366"
    sha256 cellar: :any, arm64_tahoe:       "5de42169ca7aa989b4fa71ca7d82df1ef0ad55f534721e136af106fdb224202b"
    sha256 cellar: :any, arm64_sequoia:     "f3c1d412e947054c9fb9cb6a7b100d014ebe6289f39c51dd36c4bf5c48b2a90b"
    sha256 cellar: :any, arm64_linux:       "63046014de3a02bed19e71770d014551032639d9ae02913abb739afa3531a182"
    sha256 cellar: :any, x86_64_linux:      "4d19b5b4010b85e97e18e0738d91bc4cf36491db6da42ccd3e43a90e697adf6b"
  end

  conflicts_with "imagick@8.6",
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
