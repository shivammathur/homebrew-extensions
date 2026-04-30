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
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "48550fd2dde11022416ae89cb15ccedf5325a928483ecbff351c18d9c628ba31"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a07141c40732183137916b03e049df6e0050b1dab1ff8da103fd9fa2defd84cc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5517f8f6d659e4a14b0a08a644d6b51b4749aa79d25ac846a311c5a87a1fdf58"
    sha256 cellar: :any_skip_relocation, sonoma:        "8c2531677e0ffa898673afbf76b3af900b37793ef16d51f826ea5c210255fd69"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "79f585d38da273d64bef0a51b7242ff1ac3ef573caeb38bd0bf34fb29fc11767"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9f8ab3ad6fddc1a07c18ee7c01b7d80ca19de447b9852e652ac4b3748a6c6f9e"
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
