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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6a2600900e2ee4e1723fe39574c03a3639865350377faf052fd055fce41afe33"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "26d969a07ddaa322703acf1d8ab0214ef780b9ffd58677d0b34f05f8796ab616"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bf09858652bea435b22db7ac8523b0d330982cc1a013fd652725dad26ef9989e"
    sha256 cellar: :any_skip_relocation, sonoma:        "f11b3adacd60df84eb4d63012ff5b231e68810e0ee0910beee10e6b00b355aca"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bb4f02acee5131a15fa4be8d05890e0e075caf0b74c6eb0236210a99af50e779"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a5f7b70985135e423095f55b8de0ecc3f2ebe2ea829770018f4a52a87cde9ead"
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
