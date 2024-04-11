# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT72 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.2.tgz"
  sha256 "46ac184d0f67913ef5fbbd65596bd193a2ef11a7af896a7efd81d671a5230277"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_ventura:  "731588bea3aa8fdeb42ae3a8f7ed1e0ddd0cd99387bad5b2288b8ae1d6913d69"
    sha256 cellar: :any,                 arm64_monterey: "817488861ae2c2370f6f9421b30002390e0b2558a9303ceab5837a98f7b88cc3"
    sha256 cellar: :any,                 arm64_big_sur:  "901d4b9d92d0bef803615beb25390c2557ee0b5e404f345d16e87c37018d3323"
    sha256 cellar: :any,                 ventura:        "ff3ff75c19a2bab0e6452d2c5bc25c8231bc496c20c0a7f26af2f80960610adb"
    sha256 cellar: :any,                 monterey:       "1d191bb69bb1a3374c324826521c22041297d77f30badcc115f6193a6c0611a8"
    sha256 cellar: :any,                 big_sur:        "518627feb9aae8accd34c5f4f7a6fbef61d14640be7b8d5fff0671122982ceee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e08eb845d36c42ebc7e287fc4660b6ad1d94fba955ff0f982b4caabda500a7f0"
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
