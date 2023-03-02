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
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4203e03201f41b63bca98a8fdeaad935149113a18078fa38c7ef216c7a95d063"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "97502b3403f2c302885f50b76b1cf0b0387ab43e1a2fc3f9529d8ca00c4c3a54"
    sha256 cellar: :any_skip_relocation, monterey:       "cbfbf057fbaff0ff382c6f5ef3d2a7877e8755a23b42ed1b2c354f8e782500e9"
    sha256 cellar: :any_skip_relocation, big_sur:        "2c6b1354bb45ef79ddd80a7edc7c0bd75c4bebedb7d4d7283fd1599104ca97d9"
    sha256 cellar: :any_skip_relocation, catalina:       "356a9005e01273a50260c43b6e9df90a252bbd25c7ffb24105def71ab4282886"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c4eca629705318bea18a984dc38309441c46d24c195eb15b520c3a5aa53f6f4a"
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
