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
  revision 3

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "7a42e2dcbb9e0da73f552a2aa3dc799934977df845ffea0ff7db4b9168890247"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "d2b3e0748a8bece6377f081d306f8aa0a93341a8c63660885bea7a0f941b3de4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "1cbbaa09f5924828c79cf1be4ff6b37429b01f425a2148223130e3ff1dcfccd5"
    sha256 cellar: :any,                 arm64_linux:       "53e18126524eac6ba9e5ef5047d2b5a8ab38e2f50b3ac4acb7eec6ae4a5b39d6"
    sha256 cellar: :any,                 x86_64_linux:      "af9a9826ed081fb74399b3665344a6e558cb91ff67464327b0cdf1daa9190378"
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
