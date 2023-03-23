# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT83 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_monterey: "107b5077f6be1faec1f759b8400abb80ef3a8a50641c84b3a4f1f922f10367c0"
    sha256 cellar: :any,                 arm64_big_sur:  "d1ba93c2c68532331d9579192830afa567eac5d09694601ed81de7d7213a409a"
    sha256 cellar: :any,                 monterey:       "fe5e6ef68e032c0d50b4e3bcb9ddb9426d702806921a7489fbb91c35fbd9c702"
    sha256 cellar: :any,                 big_sur:        "17d72b716be2d577c8a1c2dfab88754000c9f80e903eccadce4b4b021103c081"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "81d51fcc30a03748657d36bdbc7066cc318716b31ca8957cd5d4182376b48dc7"
  end

  depends_on "vips"

  def install
    args = %W[
      --with-vips=#{Formula["vips"].opt_prefix}
    ]
    Dir.chdir "vips-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
