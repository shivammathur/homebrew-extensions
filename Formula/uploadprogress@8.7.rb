# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uploadprogress Extension
class UploadprogressAT87 < AbstractPhpExtension
  init
  desc "Uploadprogress PHP extension"
  homepage "https://github.com/php/pecl-php-uploadprogress"
  url "https://pecl.php.net/get/uploadprogress-2.0.2.tgz"
  sha256 "2c63ce727340121044365f0fd83babd60dfa785fa5979fae2520b25dad814226"
  head "https://github.com/php/pecl-php-uploadprogress.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uploadprogress/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "68f0c2dba35ed5b841246066737da934e6564d5771ca7e1f4afaae2dd311012c"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "96f779a72093a2e6fc265ad928265c7184959819d6d17b9f193786620a29fdf1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "16ab0d326e5cedee22a0c7325faa49a8fdc71a6640667bbd9c2dced824418b9f"
    sha256 cellar: :any,                 arm64_linux:       "a4df2c8c5a84a80b5e6076591de825e16f19a6887e7f18415f92b14b2f24ea6c"
    sha256 cellar: :any,                 x86_64_linux:      "5b38dc101b1a5753a410f16646f45c80bc011c702f2e4456ac4bd5d79d746201"
  end

  def install
    Dir.chdir "uploadprogress-#{version}"
    inreplace "uploadprogress.c", "INI_BOOL(", "zend_ini_bool_literal("
    inreplace "uploadprogress.c", "INI_STR(", "zend_ini_string_literal("
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uploadprogress"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
