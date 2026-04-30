# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT86 < AbstractPhpExtension
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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6690f6125090c81a3e34ce5c09a399a502bc234807986faca6531207541f1d45"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "90a4e4e03ee74ab7a70873d72405dd12c02ccce3684e478c8eb40d40c834f037"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f7ec24de8366c6ae188caa6e49f7ac94c39145282e5f57456b26ddd15aa7d1a3"
    sha256 cellar: :any_skip_relocation, sonoma:        "01148b6e85ba5d0cfa9f1bd7754f3a7c6e1523776fe416bb4e17b290241742d8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "55f112c74be0e8a265584c2d51762139cf833960ad12bafb8974d312cd637d1c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d4a6f7c2e2f668f5afd0538775b6a8c0e2ef4270cd00a11c4ff321164810332f"
  end

  def install
    Dir.chdir "excimer-#{version}"
    inreplace "excimer.c", "INI_INT(", "zend_ini_long_literal("
    inreplace "excimer.c", "XtOffsetOf", "offsetof"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-excimer"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
