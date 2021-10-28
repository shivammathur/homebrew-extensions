# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT72 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.1.tgz"
  sha256 "101e3d244e8b4fff7391f5a2f230d4d94f01bb6a1f42cfd9539599df0f3957c8"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b789b11fc2a9db68b11de2ed2d5122e216a1176738b131aaf169a886a21bbdb5"
    sha256 cellar: :any_skip_relocation, big_sur:       "2ffc5b8cf146cf12aba52e1a28349e8156f29b2fb2571361781eba020dc05628"
    sha256 cellar: :any_skip_relocation, catalina:      "06524a86c6c68979338a8835f2b25efb4704c7e25ca5ebbd55998b0ada3a13d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9baeb2206239b93e20cce9820914a1aa7a29933c0721798080ba55b550f03aff"
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
