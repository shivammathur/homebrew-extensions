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
  revision 3
  head "https://github.com/php/pecl-php-uploadprogress.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uploadprogress/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "307ac9b8507e094ba5e3c84900f585e5b1efc838e497d3299a06d3fa75307de6"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "bc88cac2d01ec3315d125d20ac4b2de5faacf32352cbdc751cb9abd86a1efafd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "add39ea840dcec0903559b6144485aed038189fe8c2618611e94804c1a32edc9"
    sha256 cellar: :any,                 arm64_linux:       "a1b199df5ca35934a8da6b292a4fb4075247fdd362e24ae582ae32e080971234"
    sha256 cellar: :any,                 x86_64_linux:      "1d22c51c3985851d9183212bf19792adb8e543f725f2fd9465bbce51b88ef6fa"
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
