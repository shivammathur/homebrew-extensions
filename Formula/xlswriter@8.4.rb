# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT84 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.5.tgz"
  sha256 "4b8c8aacf48737c0d741a2401f4c495318ca18879e9bfcef5f698946ef28c671"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "efeef8be69ac0cadc5046670ba85ade17865bdbfc4cb10d22880606800e06c57"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6a1c937f2b9e010f0060d44e1bc8e08c8630dff6683b4d88a6bfc75a8169893d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a1e12d8fb5e4d69cec5a9bd5b094dc1c0619819740d74f83f608d8468484b851"
    sha256 cellar: :any_skip_relocation, ventura:        "40098253730759b2554bc8a20493913e508840dd888fea9903a4e35796c6fa7d"
    sha256 cellar: :any_skip_relocation, monterey:       "6250e289ac02668372e12300d0507c22e23de861d23db49e550329801639a8d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f61c2a0d2bd1e85edb0bd57a94856918c0cda250d1b23b19234706d7bd93150a"
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
