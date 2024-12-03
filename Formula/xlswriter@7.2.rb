# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT72 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.8.tgz"
  sha256 "202ab46a0fd6d66d21cf5e58bda67e58f05ff95109fd955ed67941466d1c833e"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "5700088d165a23f363cfba8abf3630f7a1ef499a60b9720e6b035c24ba17ef41"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "794290e70b0675075b952e7cdcd1c0ce4b73647d3879d18df6fa412fcdf83ab1"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3611f31b62d210b3325d2e1420e6a29a98e7476de57fb3d0d386a9f0864498ad"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5a1f25ec506b80bc66657bbf651543b4d5cd4744d0d4a7b833921574dd590e1c"
    sha256 cellar: :any_skip_relocation, ventura:        "b62c9f3f837f84451b81237dcb912c883f7571f48081e2125ffa1e84ca4b2471"
    sha256 cellar: :any_skip_relocation, monterey:       "8d408be04f9f99451b48973344786c8ca0faac9856bc99d8d74f378821f2a25e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bc1ec5ef0db9f1bed329c03acf729675d29a80b9f4bf8cdd384b78f88e644a54"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
