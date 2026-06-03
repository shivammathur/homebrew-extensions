# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT86 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.2.tgz"
  sha256 "a85ce71f02eafb2617ab125b8c97677ec8b4eab3cd81f32478a5eb44fe55f145"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "33cd3f043d09220df0debeb44237ae1a10baf37ef13d64d9976ecc6237b9f34b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "99f65b0ad6bc0e0504164ceb0b9042ec5c64a49a30e994e8e9893d96e1e359b0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0f4a7e2bcc731d6819dca144d18efcfd997ab387192f912a1acc249203cf52cb"
    sha256 cellar: :any_skip_relocation, sonoma:        "8cee162803a94c50707222a843f79d5fd563abb1a90856208837745af4154f25"
    sha256 cellar: :any,                 arm64_linux:   "9cf0748df45def9d8816c70ae5fd807c6f3a012407b02f8f04e9fcf0374376f2"
    sha256 cellar: :any,                 x86_64_linux:  "497d920092f77c96515c036c0cc0f44cfe145c2b914a22461267f601b6037735"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    ENV.append "CFLAGS", "-std=gnu17"
    Dir.chdir "xlswriter-#{version}"
    inreplace %w[
      include/xlswriter.h
      kernel/chart.c
      kernel/conditional_format.c
      kernel/excel.c
      kernel/format.c
      kernel/rich_string.c
      kernel/table.c
      kernel/validation.c
    ], "XtOffsetOf", "offsetof"
    inreplace "kernel/csv.c", "zval_dtor", "zval_ptr_dtor_nogc"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
