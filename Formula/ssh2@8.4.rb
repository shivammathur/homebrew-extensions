# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT84 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.tgz"
  sha256 "988b52e0315bb5ed725050cb02de89b541034b7be6b94623dcb2baa33f811d87"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sonoma:   "c95a0b0ff802d7c7c06bb4bca14eaa37dbcd9f47279b2e10cf0628f5064fedef"
    sha256 cellar: :any,                 arm64_ventura:  "cbf5d81f7f5ee89954624dd9938cceec4610d91355fbcf47e6d93678e5635db7"
    sha256 cellar: :any,                 arm64_monterey: "62c07ed73c5cd85130f04948a83c0be1b0242e4f7f14895950d3652b87723a6d"
    sha256 cellar: :any,                 ventura:        "5b45ea2ee49519ad6e28cd45ae5f85b8d5dfcecb7a633fadbb8143af94f30a96"
    sha256 cellar: :any,                 monterey:       "60c03aaf5e1298c098c83997be67298cb6b389cf719a127a688885d386ae2352"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eb167a6240c661f68446dcf423cb3215e90c27c4dd91e36ef268894cba19ff55"
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
