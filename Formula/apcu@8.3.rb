# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT83 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.22.tgz"
  sha256 "010a0d8fd112e1ed7a52a356191da3696a6b76319423f7b0dfdeaeeafcb41a1e"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b0de3a8c4aab21b749150486fbd989198c3a09904f241d7cdb9ef36430036e9b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a89dc981131ddb7f413bafb7d8f1ff44ac19d5180752f1a063cc33bdeee1b1d7"
    sha256 cellar: :any_skip_relocation, ventura:        "8abb80f1bf5da7cd54c8e7c704c75c62c34ac12327be54e3398ac98917ba3ffe"
    sha256 cellar: :any_skip_relocation, monterey:       "59c127c974470b122a5d2df1d4f26353b3e541e5c2f1ec9ee6ef04841b680790"
    sha256 cellar: :any_skip_relocation, big_sur:        "01a176e20097332eab72ad29a8b2d6042311ec2b11f880701e893a3af44f008f"
    sha256 cellar: :any_skip_relocation, catalina:       "373a7c5660fff17b1f82588a635d8c21f833c5518be81d2fca3600d852dd6024"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1023af2122b311330a2c1e3d6f39d8595694514e9c8a42582136b9cf23ce9757"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
