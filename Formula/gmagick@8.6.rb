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
    rebuild 1
    sha256 cellar: :any, arm64_tahoe:   "81835516a6e3cb9e9a251d7a2adc404cc76414ec12330268855a7b1ac8a5eef0"
    sha256 cellar: :any, arm64_sequoia: "f5979eabe0a1ceae59deece63fe027fe47c1b6869d1233ae82738ebaca8dba17"
    sha256 cellar: :any, arm64_sonoma:  "4a653dc234c87723736e5347f7db4fd59b850dbea225c0f6915e768f3a0520fb"
    sha256 cellar: :any, sonoma:        "9cdcd6844519bd70b3efb73b0c3dc69de9c6be76e52bb94c84f329912f3d710c"
    sha256 cellar: :any, arm64_linux:   "2f2d2e373adf2e5236da977fc1c4aeeef7f16663b3948da91a078185d52d3740"
    sha256 cellar: :any, x86_64_linux:  "283a9af89fc642c261c95c281a66480fa1b9d6316c36f66be1db8a58193f13db"
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
