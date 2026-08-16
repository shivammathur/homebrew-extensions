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
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "94af2a6edceb567acfc4dd79cb4692004437eecab4e85e2c69602a57b70cc968"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e63a0a1a17b0ffae14050068a4ab815d0907096eba189fcfaf3e5b7d81399061"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6a573509c5dc69ae7b256faf7900a57f40f90e4d101bdf62dbfe561e52ac002d"
    sha256 cellar: :any_skip_relocation, sonoma:        "2e56ec3e42b6bb0e9405ef93940201ddc739ecd7db8552db1eed040712ee2bdf"
    sha256 cellar: :any,                 arm64_linux:   "15c7b359228f46d749f63a22e21cec619e179ca16b7dfc183ddab4cd7421245d"
    sha256 cellar: :any,                 x86_64_linux:  "f7b66b3e45694a37b4639c4c21f839b3e2d8202187c0a2262cd3398b55437792"
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
