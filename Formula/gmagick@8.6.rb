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
  revision 3
  head "https://github.com/vitoc/gmagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gmagick/allreleases.xml"
    regex(/<v>(\d+\.\d+(?:\.\d+)?(?:RC\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "cf1dda1bdbfb9a55f7fbdd11ac7bf5e38d9d0fd7d799234c877bb4533e00777c"
    sha256 cellar: :any, arm64_tahoe:       "ffc27305e80d33b37ccc8cb081171fb774df42ff5277f6c0b9428be918bebd12"
    sha256 cellar: :any, arm64_sequoia:     "375542f69f2412e54fe78d743ba256925b95c066dd323ded0fb5b525743c30fd"
    sha256 cellar: :any, arm64_linux:       "ce12a98ea601ebfd0b7ed902cb1fbb27046aacb4e753c9422df1f5419c80117b"
    sha256 cellar: :any, x86_64_linux:      "e25bf28870c237d36b7d0555103878b57c78285e207623d70820711251d16e95"
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
