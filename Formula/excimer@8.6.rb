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
  revision 2

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "60d598cea8840e678108e6b501bd772b096fca3e1f519bcbb971beb3343c173a"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "3a66cd3eb24a70ad20b9456aa3a52331ad876834564a144ae156d102085e114e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "6e70e7c33683038b2e981bedd61588e70db675c11ffbf23207038873ca97b545"
    sha256 cellar: :any,                 arm64_linux:       "0bc2391ce729cb2d77469adcce6bf4eae9f09ffc26234a41a631bebc6b518cb7"
    sha256 cellar: :any,                 x86_64_linux:      "3567fe27db4bb7e0cfb23492fa6a650ff4cc7cc490a21e1a130d40d0727ac3d9"
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
