# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT87 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.6.tgz"
  sha256 "7b5fe1f68f2b1a62bd0394d4bf165eafe6b7ceb3fc20ab885e733d356db0d034"
  license "Apache-2.0"
  revision 2

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "5ba4b20511e2b5f0ac59dd1846363ea24f346bbe9743fbae9191f6cc56f5206e"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "d1a4870ed5c76dea081e5fda1321f2585b249e3d1c3f3cf1dc2e343eed406fe3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "05aa5f94d07148ebf400e16e7265113e6015d56f0864fd9007b2a8753895bd71"
    sha256 cellar: :any,                 arm64_linux:       "48ddd73eb963f48746ab057647b983cd29abf160ab995ece4087d775cd1eaf33"
    sha256 cellar: :any,                 x86_64_linux:      "2d7071c4742c0dc1516011c584af56663635e83cd4ba2aa69bdb78b774c8f79c"
  end

  def install
    Dir.chdir "excimer-#{version}"
    inreplace "excimer.c", "INI_INT(", "zend_ini_long_literal("
    inreplace "excimer.c", "XtOffsetOf", "offsetof"
    inreplace "excimer_timer.h", "zend_atomic_bool", "atomic_bool"
    inreplace "excimer_timer.c", "zend_atomic_bool_store", "atomic_store"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-excimer"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
