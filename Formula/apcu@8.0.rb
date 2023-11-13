# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT80 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.22.tgz"
  sha256 "010a0d8fd112e1ed7a52a356191da3696a6b76319423f7b0dfdeaeeafcb41a1e"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7b9a4473448a799c978ccf2a2251a994d5b1023dafe05d89ab9b0b1e32fd0005"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "61bff35a4d3ee8d9f9e83fd0030d078169871bd82cc7fe7942c93b475e725571"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "62d2c64398f1e45db0c04107a17e8150dea215fc5cd6fda3919297b0319dd670"
    sha256 cellar: :any_skip_relocation, ventura:        "77fffc18ea4cc5d95454563034c7a58e3f55a5b28a103c15e0c515f818c13391"
    sha256 cellar: :any_skip_relocation, monterey:       "d97c1bdb703a9f809eacc1a5633c7ce7a18e513889d94b39cad118a7050c31de"
    sha256 cellar: :any_skip_relocation, big_sur:        "5cbee79a5f0c9d18e947a4dd8a7daaf240dcf12624dfff54edc7b8ec0c58433a"
    sha256 cellar: :any_skip_relocation, catalina:       "cf9df1e1564fd87187d264d66a8ddade4fbd54c59399eae9913b98d1f66e25d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8518cb368994bad4119758ccfa684b46172da106f184c8bcc97a326b78eceeff"
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
