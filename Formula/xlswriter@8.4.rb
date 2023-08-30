# typed: false
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
    sha256 cellar: :any_skip_relocation, arm64_monterey: "93fe9f07a1cae9fffab727c6c8d50a3d4a720aa19a02068c757a00365a5f6603"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c8258330d57b355ece7b7c609c4a616e7cc95d8e9e91dab6bceb43b99865aa26"
    sha256 cellar: :any_skip_relocation, ventura:        "8d680fbe924f16c0456dceb462654c7b9804c1804d28f6b37349711607ad98ec"
    sha256 cellar: :any_skip_relocation, monterey:       "cee89f460cc241239950a7ee7d8e2bc1dbe5b38fe0bc7deb5d0ab336e1a93c39"
    sha256 cellar: :any_skip_relocation, big_sur:        "cd9eedadcfbc922d954e86030ec220b855447c95eba4ea14931c4a9df2b14a0a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bd94d52879d1f4a191281f8984180f5a6982d41c98af25275da3ac4991112711"
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
