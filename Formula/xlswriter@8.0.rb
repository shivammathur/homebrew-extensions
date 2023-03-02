# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT80 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.4.tgz"
  sha256 "6df4198ac50366317bbecdfd08d34047cff517465be48261849f50b833da0b73"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8c62d0d599d334786c4a709c22135fa2275bac54ed26bfad76c9e44d40bf2b42"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "6c1b96e1c42e5263537c4352ffbca079588a77af5d7fa740b71898e71a0ea827"
    sha256 cellar: :any_skip_relocation, monterey:       "f8e1f7d648798e2994f91352d108fc8b8f70ef4716b189de1e61d32e2571d23d"
    sha256 cellar: :any_skip_relocation, big_sur:        "560225ace05ff8df352042e70237159495bbf1e19c6c99fb2e2941716ad9713f"
    sha256 cellar: :any_skip_relocation, catalina:       "1b7efd4a9e124885496d97c75d9e6c269b1ba39f3e7f0e9009206661064d7a88"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "733fc8ca633220d48b7f61c84dd89ecdf3be79aea8a197b029f1871e07769524"
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
