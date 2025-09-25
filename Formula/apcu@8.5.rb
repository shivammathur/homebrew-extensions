# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT85 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.27.tgz"
  sha256 "1a2c37fcad2ae2a1aea779cd6ca9353d8b38d4e27dde2327c52ff3892dfadb3f"
  revision 1
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "787fee9d501d1b62b131b5de97f294d565f694c1d71f0f545ebeb5e71820c61d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f88a402e83b023010602c62c66983da4d98c567619da448b371325f28ba3ec87"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "64e014b90ce1f6f21c7ca95d63508fef30ff5284fa8f4871a22cc0aa850c9596"
    sha256 cellar: :any_skip_relocation, sonoma:        "acb74abc00c9bc9e2660aad201485e16ee7ba7155820b2ce18da26547298f03a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4b1dd288d7e9fa95f6331f6f259a70de36538ed5ef70e734c9f6865540db0b4a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e63e8306e5ab1638fa6d2416f22a82fc00d4d802f494c11d75fd589ab080ee93"
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
