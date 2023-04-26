# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT73 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.4.tgz"
  sha256 "6df4198ac50366317bbecdfd08d34047cff517465be48261849f50b833da0b73"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "21835ce2b4ec5dc031432f9553c8e940ad64e7a65b92f8391191cf9a7c1bcea0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e1a43635f062c9935ccfb10f147c1e5fecce05eb49cccd05fd1de4fec7f45f15"
    sha256 cellar: :any_skip_relocation, ventura:        "5db0af6db998e8d1d3fdea5b77f9a071c9ae8b1e4d2c233040e02b16b4710e23"
    sha256 cellar: :any_skip_relocation, monterey:       "b5b191085770f17aa666d55a09ea97d7a43e588f7f008c90e62c298a0ea51754"
    sha256 cellar: :any_skip_relocation, big_sur:        "60dcc536a952aaa91d5536208183aaf567d36e7a3a1577259a0f1a51ec9d8fec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "af730cfcad70cda363b90d4a879c0bbfac5a645a79e32c7bd036e49ef05c97c8"
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
