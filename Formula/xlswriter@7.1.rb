# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT71 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.8.tgz"
  sha256 "202ab46a0fd6d66d21cf5e58bda67e58f05ff95109fd955ed67941466d1c833e"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b1a099c535af7be8f0f57d484fa0d58c8bc74ca4815281de182686707382000b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "13e7055165779f01b1c6bb84814e4a916005ae0c4e9d859541e6aa2bfdb43449"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "90304e677cfb9f9216079ab0f2e99823fc7d88bca491c2adad0f9c052a7f8afd"
    sha256 cellar: :any_skip_relocation, ventura:       "6425854f2bd3cc9ee04908319051bfdfaff4fcd2b8511771659c377d71b874f6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9ca413673aac8610251a4f1a4f41ee9765a42da44f295d8523a8b8cc63587983"
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
