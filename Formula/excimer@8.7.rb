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

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "ddbe78e60aab12eec611c9645e633b1ba11f3d94b6c2e48f4028abbe4a907065"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "5803477a5ef54090c8b24043c0d58722dcdd9309e022ed87ac992614373f2e6a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "dccb98ed30e493c798bb3cdbe39db6c7273f4f39132636c5c4b526592f5c62e1"
    sha256 cellar: :any,                 arm64_linux:       "12fc4f2d1b202a9343eb2ac1b5c080ea242649b04733503a77f480617d4cd642"
    sha256 cellar: :any,                 x86_64_linux:      "b6c4fd46ef9b211ebc2c97391999bcc766300ee74274218efd2782328ca62bac"
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
