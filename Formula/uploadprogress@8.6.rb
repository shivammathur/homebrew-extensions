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
  revision 2
  head "https://github.com/php/pecl-php-uploadprogress.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uploadprogress/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "f95155733a86d9fa66303840e9d6ba32f2ddb9a02cd7f78048799de6e5b2b634"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "823db7c9f41b9a785714e119d84a9f14751bdb4932a23717af0f39ebbeea1a96"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "9228b22af0a7ca79bb5e364b1459784e22d6e592da787da0208d719f2d8448b2"
    sha256 cellar: :any,                 arm64_linux:       "cd911b31d3a6574215290c5c03e57a5460be50a9e7e4c63166569584656507ff"
    sha256 cellar: :any,                 x86_64_linux:      "c4f0036ef302fde8261ac90e925ff9f30a117b5201b7edc45d965e8ef7a57d86"
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
