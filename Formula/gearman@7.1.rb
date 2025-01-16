# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT71 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.4.tgz"
  sha256 "1b16ae5e17736e2ce892fd96145fa8b9e1724106458535d0c7e3d4093a9091a9"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "991dd02c1ef41a932dcdf5e60fc81d233e52685d910e765f17b041b4d2d84c00"
    sha256 cellar: :any,                 arm64_sonoma:   "72dc62d348d576f8113f2db0c6e059e48473858f855fb0e3248be3291afdd26f"
    sha256 cellar: :any,                 arm64_ventura:  "eda715634ee37167f4afa6e24bb1466b00ee8a3c299744168de0fe0270685c39"
    sha256 cellar: :any,                 arm64_monterey: "86c8ac41ad21d9cc134ae175cc6b56c22275676c8b9cd043c282cbd4d8bf2366"
    sha256 cellar: :any,                 ventura:        "b570a286ce62bb9ab549e3c9b28f26f6a6c5b55903b6d902669d63708d511202"
    sha256 cellar: :any,                 monterey:       "ef3460423c0ac27e7e859d7e1c79878dc65844c21d1995f3a7d0f5bf8f15e4dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a9a74bdfd92e4e35cfa856f85aceb127e325aa521b7373b13b23f87ef0dc67a5"
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
