# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT83 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.4.tgz"
  sha256 "6df4198ac50366317bbecdfd08d34047cff517465be48261849f50b833da0b73"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "76e65caf9e5c44ca448608e8a5150293642f65ef613f3d272a4af679dbb5f74b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5ca0ce8259f56abfb9989e6c512d1e897e4d98bba1960dd24aabf521e9fda34c"
    sha256 cellar: :any_skip_relocation, ventura:        "8b79115b6b3027c7a53a43ab2b73865aa09363df34bae2ff478f2c1e7686cd3d"
    sha256 cellar: :any_skip_relocation, monterey:       "761f19cf9b6918abe665ac39cc361167290eaf40882be824403db354090d4a01"
    sha256 cellar: :any_skip_relocation, big_sur:        "26467d2550b18e35bbd1704047965aa63982121bc613f8f74e271d2442166c2f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a8bab5bda6c77a0326bd2e8e65d2216d6182bd50a3ec25574c33f838585a25a6"
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
