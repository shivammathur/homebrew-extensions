# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uploadprogress Extension
class UploadprogressAT86 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "42dab277bebea480b0cb3ff7cac130134ede111df245e7dae13950e50425a1d5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "460929e09c35010ad12357201331c08ba01af8bcd4d65ac74efe8bb644235ad4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "74d407063313abd9da6b148a94163da3d063bdc67770ef54b4b3494c71b1ea79"
    sha256 cellar: :any_skip_relocation, sonoma:        "805828186fef3c92e26b6bb36805a0a88913227937f40736a3bbdd2801089d12"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b4cfa1286cf4094d8781d60ab43a6974d415f1f338b73154f7fb8b154c160e52"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b8730604895f03bd1672ccd814e3623d1fd986538fb89265057a69e6a2b60da3"
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
