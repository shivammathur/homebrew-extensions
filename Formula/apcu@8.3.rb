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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ac99f525272103917af8b1d4772ff200abec7c469e6238e1e5cc822b3b15fdba"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "4d877450eb52617d34a114e6f8b3a66adaf2991c925ca66888c420dfb76a3831"
    sha256 cellar: :any_skip_relocation, ventura:        "ea26f54cb3a6da2d9385bd6d7723c837ac1e395214c245909e185dda8398b6ee"
    sha256 cellar: :any_skip_relocation, monterey:       "30964b86d80bddffb4a6402d33fb6bf2d1ece37d9ad763aec3bcf2b836d87ca4"
    sha256 cellar: :any_skip_relocation, big_sur:        "0634599e0576dce1e92ffee254929e7f63719b017459451aa8c015b6f05612de"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a351bdd81d5a01e7c7383591189cca09af14ba63d0f5718082b9b84cd081bf7a"
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
