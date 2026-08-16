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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e7ffd32a339429dd1eb5f0462f1001efdbb1d414378956fa05191218efaac445"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a9cd3d847dadb10c55211ffe78a3fd90bce28b7ccea949e5c042d356298dc8d3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ebdb74e9ba465c363c5128640ab2fea0a8249cbda8717674a1c6dedd3e5621e0"
    sha256 cellar: :any_skip_relocation, sonoma:        "56ef3a77569cfc4ff3cf38e4ff8d03448fec535ec335a0765157561f899759c4"
    sha256 cellar: :any,                 arm64_linux:   "52bea17f9dfdd4630c8e46ee1c0a69fad000815c3870ff8014fe2ba4abacef99"
    sha256 cellar: :any,                 x86_64_linux:  "2fa67be7452ddb1a2e8a7f23719f8f463c978be114bec43647c2a0873d328415"
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
