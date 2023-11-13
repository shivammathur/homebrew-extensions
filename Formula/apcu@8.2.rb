# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT82 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.22.tgz"
  sha256 "010a0d8fd112e1ed7a52a356191da3696a6b76319423f7b0dfdeaeeafcb41a1e"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e64d1346f84cb2c3690dbca8a6c1ca8c65b4074531067a7391e8575d849ad654"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "949b641016d58bb3f2ae3942500d016538964b9b5473e21dfabe5836bc9adfc1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "34e8c728d62f24d567298069628fc40af9bf1c6ade57dc945fc8dce9fef5696e"
    sha256 cellar: :any_skip_relocation, ventura:        "b0fd5f4a8571a8acc89f28140bbbc3338dadb6602f5229521c043c8afa6b7064"
    sha256 cellar: :any_skip_relocation, monterey:       "b05d7f9fd55581684a7dedd79783fa0bbdf5e6ac81e01f325f0f11d28b0a91f3"
    sha256 cellar: :any_skip_relocation, big_sur:        "72b702927c2672144350330c7459705fb25aeacb76deb72fdd2ed266081b31fd"
    sha256 cellar: :any_skip_relocation, catalina:       "3ebbc118aa33b3e1c6f182e679aaa1c266f61047ee282d165bf98a28607fd74e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "45a97718f6c61b5ee2dc3ad0a1e7589577e402fa18908bad587fab87787315b7"
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
