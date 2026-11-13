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
  revision 2
  head "https://github.com/php/pecl-php-uploadprogress.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uploadprogress/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "15bc6b62790709ed81f077e9f3ab1791f8b294a5adb12c7e12c16aa1c4187cf7"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "39a8aadb0541ec8035f7edbb08d153a9e13511fb608a51d9660ad9c61ac395a0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "04cf511470a8fef703f3b6c581654ecd7f8be0c8a8172220387db365c7f76684"
    sha256 cellar: :any,                 arm64_linux:       "14f0c7d1742cc67770376201fe43715e830b5b8fecdf1891061a2a1d01e31a8e"
    sha256 cellar: :any,                 x86_64_linux:      "436df33281f470d28ec0c5ba9ffed5cd13db9d138b44988622577a0cd4811cf0"
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
