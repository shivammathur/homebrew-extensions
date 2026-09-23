# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT87 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-3.0.0.tgz"
  sha256 "a17986ad5ac09529513fc59b2871ca2b53eaec1c2c55cf00be60a292e85ade73"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "2a7261a88fb12008c17bc2582a256d7113b162456bc8755672a23dabd3ef1585"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "2f68390b79bc4694c8a3cd9c3ec3c6a8b7fb80608f99b0736c89bec78db2f191"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "4b1aa16b85121ff0ce479034deb2531ce933d19afd5a0da0b4305862da6da482"
    sha256 cellar: :any,                 arm64_linux:       "4981ae8797731f1521b7b27cb36ec27466aea5cbd8c11dfe6011ec078021ece4"
    sha256 cellar: :any,                 x86_64_linux:      "479bbc52ecc88ab1c649213304c08fdb69e871d780a0a790125533bfdea039a5"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    ENV.append "CFLAGS", "-std=gnu17"
    Dir.chdir "xlswriter-#{version}"
    inreplace "kernel/common.c", "lxlsx_datetime timestamp_to_datetime", <<~C
      #if PHP_VERSION_ID >= 80600
      static int xlswriter_php_idate(char format, time_t ts, bool localtime)
      {
          int result = 0;
          php_idate(format, ts, localtime, &result);
          return result;
      }
      #define php_idate(format, ts, localtime) xlswriter_php_idate(format, ts, localtime)
      #endif

      lxlsx_datetime timestamp_to_datetime
    C
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
