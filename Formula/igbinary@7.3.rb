# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT73 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.3.tar.gz"
  sha256 "c6bb38235e166ddf5713f464f9ab6d16e85783eefa7825824efd252eea6ac4e5"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "78715499910e73690607096609a7d903c538b89343db309855d2828f0820f6db"
    sha256 cellar: :any_skip_relocation, big_sur:       "c74bfb6a41b464959834ade583aac3470f5321d6eca57cf8fe329e711011716f"
    sha256 cellar: :any_skip_relocation, catalina:      "f90c0da1b8a2c4afc88699aa3107da35f7a8b685949ae23a0bbbac5dea263a83"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
