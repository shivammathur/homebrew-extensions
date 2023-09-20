# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT71 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.22.tgz"
  sha256 "010a0d8fd112e1ed7a52a356191da3696a6b76319423f7b0dfdeaeeafcb41a1e"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "2197fe54bdbc43bca606eecebcd9a47b6e8f3781328593e56e37594233167fa0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c575bd61c9a442b193a2bf0d26c05eabcc7a126e4bd2696f3cc377f89dc641c1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2df685a037d39897c7e4805635b331957fae1e079a4101d25b49542f0a88f502"
    sha256 cellar: :any_skip_relocation, ventura:        "86cf8b225516090998e11be879ff94891b876f56c46fda3908f6bd83cc076b13"
    sha256 cellar: :any_skip_relocation, monterey:       "6a20221553da8adf80fc6193ff5739c512b01bc58c5d7f044fc0a6ef4e99e2d8"
    sha256 cellar: :any_skip_relocation, big_sur:        "10186d14dcd3fc704bd98f4b1792da220c559761ab543d80c5fc293940baa7b2"
    sha256 cellar: :any_skip_relocation, catalina:       "64e71d7df973fa6bbf262b7706a15fd3cd53f109c4a65a2d044bfe6e90b63a66"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0f7ee1980d23ae99731e74d8fabeb859e991c4b48cef40e33ff2359c664d8ac7"
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
