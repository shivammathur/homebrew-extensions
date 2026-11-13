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
  revision 2
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "df92841addf4b91e88d117bc73160778f5849387479379b332373c827de149c1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "95dfee6aa688b038003b2e292b18ce6c8812778dba9b30b5bbb09d777839ee15"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "5e75b6b70a46dd910e04fb5e278618fb7587a1fc22b8ecce631f20619c083f18"
    sha256 cellar: :any,                 arm64_linux:       "37ecb80caaa878beedb106e41f52d6f8f198de88072e0d87da6ab78b6c300b44"
    sha256 cellar: :any,                 x86_64_linux:      "aa3e9235894df9b6ada43afc1ad0bcf729e79c5c789ae406ca468f05fb2fa8d7"
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
