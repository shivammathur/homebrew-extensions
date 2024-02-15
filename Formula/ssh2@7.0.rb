# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT70 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  head "https://github.com/php/pecl-networking-ssh2.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "579753868d80a292d9255734ddac84a0a0233349e94f0ba264b560ed6741a049"
    sha256 cellar: :any,                 arm64_monterey: "5f539b995d719f38c2d9710bddf8bafaee8bff69ec786c51514bf12dd89c08ea"
    sha256 cellar: :any,                 arm64_big_sur:  "872b2f6a83b2f057ab7b50709331797b2bc82bfd9d5aaa04fcc470e8cc7fec71"
    sha256 cellar: :any,                 ventura:        "37a8d9c7b5e2254f176ce0002002ba5c9ce088fa1a46e7b96e9a6d1432546517"
    sha256 cellar: :any,                 monterey:       "5d418883f19aaca9a88e56141f54d467e604c609966070761d51c2bee3407b83"
    sha256 cellar: :any,                 big_sur:        "d5d768f95a25d65b62f5fd7ae468fbb7b3d1ef7feedcb722fc7397ef0dc58f0f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3b0c6235f0239bb73dfc99e5d1110718ee97503c93a258426c3c00e40642e5ec"
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
