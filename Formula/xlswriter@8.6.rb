# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT86 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.0.tgz"
  sha256 "0562a41c958a20780b492f91c3815744d976e42e4adac09edb4d2c5add7b0cc7"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "999f9f643e94cbdb7c24bb941ee63c935e3f2e00e993db55e0f80997e443efe2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bb04bf19865d6fdb4891a13ff92a63826799eb8bf0928d78827196ed344ff683"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3768024b04495561c1f4ab70efcc11cf8cc607ed8e58c2da03d44e345d32eef8"
    sha256 cellar: :any_skip_relocation, sonoma:        "dac0e0d61fe946f2cb76e39d58bcb0f37f5c65df4871dcb88ba2a6a336071afe"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d60da971395145e9c335df1c2afdba03d9ffe5ad2385e8f9dee3081165258aa9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "05c92d2115843387ef8872a03831d263448fb466e3a0912c2339e2e3def7e341"
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
