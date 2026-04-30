# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT86 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.8.tgz"
  sha256 "202ab46a0fd6d66d21cf5e58bda67e58f05ff95109fd955ed67941466d1c833e"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e8ae97f266677054b534193f5f1892a39862969735b3dbebce1c8dbce1314465"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8786ae098336f1b00688340ece10bc7162c129e1aedd2f07227a1f6c4ae7bfac"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "89a3177bfb7a91c67d205859c2ca980225fd3a8b6a792a9815d060737d058891"
    sha256 cellar: :any_skip_relocation, sonoma:        "39eb818f06b7cb231b967e872b12fedf9a9f1c46c030b0983f1324c6a23505c3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3971afb3c5d992f74788d77182f8534450776925eb3d504a3b9bb44feddc276d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0a30f5e588b6812e1df1c5c9b1660f0b777f0a56dafcf5d197cf79ba5a0de72a"
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
      kernel/excel.c
      kernel/format.c
      kernel/rich_string.c
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
