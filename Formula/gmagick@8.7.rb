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
    sha256 cellar: :any, arm64_golden_gate: "3745e01cd7717635cedbd7f70a8faeca5930aa90c47b98c6cc7eaebcfa60dbd5"
    sha256 cellar: :any, arm64_tahoe:       "00ebc2c1aa3799060f63244885c88c69d5b9f88f3e22a7ae6ddc953aa473e465"
    sha256 cellar: :any, arm64_sequoia:     "8829e4e899bef3cf288d276b683f66714f507243685df0d691324e719a8404b8"
    sha256 cellar: :any, arm64_linux:       "29f6049c9f760399ddde8a3fc72ac5de20fc7dcf4ad72acfd68aefc7f3dd818c"
    sha256 cellar: :any, x86_64_linux:      "e7b98b743110c1fe21e221874a05843309f37671a50ab460d33773f4523a6ccb"
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
