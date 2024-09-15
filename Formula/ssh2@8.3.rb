# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT83 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "46ae88ef909464e05d998020222e5278c604d293d18ee894587aa7ba7a810d38"
    sha256 cellar: :any,                 arm64_sonoma:   "704130d2847ce6a2d3ece9446c45e8d49224e55d2bce8fae1ccd4237f6026594"
    sha256 cellar: :any,                 arm64_ventura:  "b135cb551f1635f2e7f7d24f01ac5f248d70351eb2f6bb9f5c3b10925a84ec24"
    sha256 cellar: :any,                 arm64_monterey: "5dbb977e902e902b0aa3d74a543e5f4ffcbe48f8118c099fd56f8418981745db"
    sha256 cellar: :any,                 ventura:        "58be0f1be1b9d5560d3c871ee94d8255095c9eb89b60c8befd8c31d58ca01fc8"
    sha256 cellar: :any,                 monterey:       "19f2e606bacbabdf3d3c32bb9c6c2e107d2b65ff2c580cfe1d710664c4daff1e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c4a8238052770c016c8a66847aa8798fb48ca59477329899bb0145305297f18d"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
    ]
    Dir.chdir "ssh2-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
