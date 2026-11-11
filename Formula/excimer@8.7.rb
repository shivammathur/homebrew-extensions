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
  revision 1

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "251a19114d7b2ac1482d6e77376c9e090148d0edfe11bf0e3f27217b6783eb55"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "345daec7e117f945e8822f5eae3fe6a7675f74b1a895e957400712acbceb7de7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "230a2fba7dd72404b2806f58ff9d406f66793666f7cdc7219befe715c9586926"
    sha256 cellar: :any,                 arm64_linux:       "902b53e57497877c674e5e8edddcf1f9aef7b692260641d1a707ab952ff5e415"
    sha256 cellar: :any,                 x86_64_linux:      "49fa2220b79df54cca206a4e1db99769faad4c430069803f16dc76eddd4be6b5"
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
