# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT83 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.23.tgz"
  sha256 "67ee7464ccad2335c3fa4aeb0b8edbcf6d8344feea7922620c6a13015d604482"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b9d4e7158a6e73bee3a568f3ded7b60669bda062f8e5517a14c5f5ba5a693ede"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "de3fe064f9615fdae4b6c7e32296049540cbe477ddc72afabdc7d154111848fc"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c21b486ffb801344ae9e1b0e3f404f2d6a390c828cdb378411355b65d626c465"
    sha256 cellar: :any_skip_relocation, ventura:        "84a00fdc6afed3170365dc97b8c7b86fdca20c1c3d148d5152a89d3f54a9ce9c"
    sha256 cellar: :any_skip_relocation, monterey:       "4b43b52f0b0fb06ed4bca1dfdbf5bfd8a434afa179ef515f825ecae9f8c34a52"
    sha256 cellar: :any_skip_relocation, big_sur:        "09f6f10f3aeff43dd46fc1ddea3a88202ed4bc9303ed9ae3594f799a017db663"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "492a16d6d230a5372e801e0a8eb4ecd98a85a9f06778b9f459c98efab6e4ed7a"
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
