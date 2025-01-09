# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT81 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.4.tgz"
  sha256 "1b16ae5e17736e2ce892fd96145fa8b9e1724106458535d0c7e3d4093a9091a9"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "99724a39a93c126bd47da445d4266c185d9a52ec372b9ab67f66a04f3254880c"
    sha256 cellar: :any,                 arm64_sonoma:   "0ad16edda3bfa200e000ce37304e438172c9780321607da4d5dda9f9409dd50a"
    sha256 cellar: :any,                 arm64_ventura:  "9902dba8492aabe6b938c16133f39a81a9b902ac9554a74442dad2717513c0a2"
    sha256 cellar: :any,                 arm64_monterey: "630d516a5ec1261c85fa09a22c61aba6c89135c1fb4b34ede4ba785413e4d3fd"
    sha256 cellar: :any,                 ventura:        "93f82b0f96b1899820f2db631d7dfe51c18db38f38cbf61a66e2a82ae062f11e"
    sha256 cellar: :any,                 monterey:       "0874076a0e529c46cf9874f745831a5d6a52a35777e981324572e93b153cb0df"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "635ae82ca61082dd4d91b9c5576904b191571572fa0946f73f7f662f266d22bb"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
