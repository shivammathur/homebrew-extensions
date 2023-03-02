# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT81 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.4.tgz"
  sha256 "6df4198ac50366317bbecdfd08d34047cff517465be48261849f50b833da0b73"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f56b333022947867f8347afe670ec56a0818b0e6e468f44ab2cfe994b9175ac5"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "8b04e944967b9b405b31cb098584beb4c63820f2b0165124b805ed18fb1c40fb"
    sha256 cellar: :any_skip_relocation, monterey:       "da05e7d41f81da3385a351eaa96b6803534e423026a44ae0fcd8963e48226980"
    sha256 cellar: :any_skip_relocation, big_sur:        "1cc9308eee7595bee73ed05502064e09b683530ebd5d5380a7969a35c331febc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a262bf50a8de2ae1406c84c704b2572d25ab4f3e6f8797fcf157f237441f6d49"
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
