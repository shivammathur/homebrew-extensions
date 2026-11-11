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
  revision 1
  head "https://github.com/php/pecl-php-uploadprogress.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uploadprogress/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "166fe27d79371844e7a027d191d23f7efd529279ce26fc14eb608a39bd592854"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "76570ec908b265654eae1adbf9be9a35337422aaa5541eb8a9f31a065e2cad99"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "a2845072e390a3ba19e6895a426dbc70f0f016d256e9bb6c68330bd91b6daf00"
    sha256 cellar: :any,                 arm64_linux:       "79a72143d587975baa58c052dd8fadc5c21311eb2c0e39e3781cf79d8460c3eb"
    sha256 cellar: :any,                 x86_64_linux:      "58692d3708e45f058c6bc748092af49f0a3ae092c2ac141404ea40f4c1240f01"
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
