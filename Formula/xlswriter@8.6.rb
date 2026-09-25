# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT86 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-3.0.0.tgz"
  sha256 "a17986ad5ac09529513fc59b2871ca2b53eaec1c2c55cf00be60a292e85ade73"
  revision 1
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "4eb4dac47a0b7197ee1687926f2fa59548af1cefe571c8aef8185bb9eb1d49ce"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "5dec0e9b503cf2c73a058e88a10303051d022a8384c9c49d7687648518957206"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "b511d79941e708802bfd7d38bbce29dea751cf34d46ce307a617d2cbfc5fa491"
    sha256 cellar: :any,                 arm64_linux:       "48e7bdad7400ddb42bf1780b13c12b1c93514fbea4c423641c0a9f45501c7b83"
    sha256 cellar: :any,                 x86_64_linux:      "c62f1d4ddc7402af4032f7675d0a827d8eda93b940c71c713d804b45024db0c0"
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
